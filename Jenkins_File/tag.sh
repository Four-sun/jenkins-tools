#!/bin/bash
source /etc/profile

echo "======================开始========================="
cd $WORKSPACE

if [ ! -n "`echo ${tag_version} | awk -F"." '{print $2}'`" ]; then
	echo "ERROR: 没有填写正确的分支版本号！！！"
    exit 1
fi

release_stage=`echo "${tag_version}" | grep -c "-"`
check_dist_branch=`expr "${tag_version}" : 'v*\(...\)' | tr -d "."`

if [ "${check_dist_branch}" -gt 41 ]; then
  echo "当前分支版本高于4.1版本"
  if [ X"${group}" = X"dt-insight-front" ]; then
    echo "前端打tag"
    if [ "${release_stage}" -gt 0 ]; then
        echo "前端tag填写正确"
    else
        echo "检查填写的tag"
        set -e
        exit 1
    fi
  fi
fi
  echo "检查合并分支结束"

remote_branch=origin/${release_branch}

function clean_workspace(){
	cd ${WORKSPACE}

    [ $? = 0 ]&&rm -rf * && rm -rf .git .gitignore
}

function checkout_code(){

    if [ $group == "customltem" ]; then
        cd ${WORKSPACE}
        if [ ! -d "$group"  ]; then
            mkdir $group
        fi
        cd $group
        echo "当前路径----"
        pwd
    else
        cd ${WORKSPACE}
        echo "当前路径----"
        pwd
    fi

	if [ ! -d "${project}" ];then
		git clone -b ${release_branch} ${git_repo}/${project}.git
	else
		echo "文件夹已经存在"
        cd ${project}
        git fetch origin --prune
        git fetch --all
        git checkout ${release_branch}
	fi

    rm -rf pulllog
    git branch -a > branchlist

    #======check release_branch is exist ========
    if grep -i "${release_branch}" branchlist; then
    	echo "========== ${release_branch} is exist ======="
        git pull origin ${release_branch} > pulllog
        if grep -E "CONFLICT|冲突" pulllog ; then
        	echo "ERROR: pull ${release_branch}分支代码存在冲突！"
            exit 1
        fi
    else
    	echo "========== ${release_branch} is not exist ,please check first ========"
        exit 1
    fi

    rm branchlist;
    git branch
}

function fetch_branch(){
	echo "remotes/${remote_branch}"
	git fetch origin --prune --tags #这样就可在本地删除在远程不存在的tag
    git fetch --all
    if [ -n `git branch -a|grep -E '.*remotes/${remote_branch}$'` ];then
    	echo "这样就可在本地删除在远程不存在的tag"
    	git checkout -f ${remote_branch}
    else
    	return 1
    fi
}

function merge_to_master(){
	echo "=========== Merge ${release_branch} 到 master 分支============="
    git checkout master
    git pull origin master
    git merge ${remote_branch} > mergeout
    echo "Merge结果如下："
    cat mergeout

    if grep -E "CONFLICT|冲突" mergeout ; then
    	echo "ERROR: 请手动合并${remote_branch}到master，因为存在冲突！"
        rm -rf mergeout
        git reset --hard origin/master
        exit 1
    fi

    rm -rf mergeout

    git push origin master

 }


function get_tag(){
	pwd=`pwd`
    echo $pwd
	if [ -n "`git tag | grep -E "^${tag_version}$"`" ]; then
  	  echo "WARN: GIT中已经存在tag ${tag_version}!"

	  if [ "${ignoreTagCheck}" = "false" ]; then
      	  echo "ERROR: 若想重新打Tag，请手工删除tag [${tag_version}]后再尝试此任务!"
      	  exit 1
	  fi
      echo "删除tag ： ${tag_version}"
      git tag -d ${tag_version}

      if [ X"${group}" = X"dt-insight-front" ];then
      	echo "前端打tag"
      	#yarn install
      	#npm run release -- -b ${remote_branch} -r ${tag_version}
        /opt/dtstack/node-v8.11.4-linux-x64/bin/standard-version -r "${tag_version}" --infile CHANGELOG.md
      else
      	git tag ${tag_version}
      fi
      git push -f origin --tags
  else
  	  echo "=========打tag到 tags/${tag_version} ！！！============="
      git checkout -f ${release_branch}
      git branch --set-upstream-to=origin/${release_branch} ${release_branch}
      git pull ${release_branch}
      git branch
      if [ X"${group}" = X"dt-insight-front" ];then
      	echo "前端打tag"
      	#yarn install
      	#npm run release -- -b ${remote_branch} -r ${tag_version}
        /opt/dtstack/node-v8.11.4-linux-x64/bin/standard-version -r "${tag_version}" --infile CHANGELOG.md
      else
      	git tag ${tag_version}
      fi
      git push origin --tags
      #git push origin --follow-tags master
  fi

  echo "=========== tag 列表如下：（只显示近期的前3个tag）=================="
  git for-each-ref --sort=taggerdate  --count=3  --format '%(refname:short) %(taggerdate:short) %(subject)'
}

function delete_branch(){
	echo "=========== 删除${remote_branch} 分支=========="
    #git push origin :${release_branch}
}


project=${project//,/ };
arr=($project);
#遍历数组
for each in ${arr[*]}
do
	project=`echo ${each} |sed 's/\"//g' `
	echo "$group     &   ${project}"
    git_repo="http://gitlab.prod.dtstack.cn/${group}"

    checkout_code

	echo "================= merge ${remote_branch} to master==========="
	fetch_branch;exist_branch=$?
    echo $exist_branch
	if [ $exist_branch = 0 ];then
    	if [ "${isMergeToMaster}" = "true" ];then
        	merge_to_master
        fi
    	get_tag
    else
        exit 1
	fi
done
