#!/bin/bash

function clean_workspace(){
	cd ${WORKSPACE}

    [ $? = 0 ]&&rm -rf * && rm -rf .git .gitignore
}

echo '当前feature_branch分支'${feature_branch}
echo '当前dist_branch分支'${dist_branch}

if [ -z "${project}" ];then
	echo "检查分组和项目有未勾选存在合并失败！"
    set -e
    exit 1
fi

check_feature_branch=`expr "${feature_branch}" : '.*\(...\).x' | tr -d "."`
check_dist_branch=`expr "${dist_branch}" : '.*\(...\).x' | tr -d "."`

function check_branch(){

  if [[ ${check_feature_branch} = '10' ||  ${check_feature_branch} = '40' || ${check_feature_branch} = '41' ]] && [[ ${check_dist_branch} = '10'|| ${check_dist_branch} = '40' || ${check_dist_branch} = '41' ]]; then
      echo `expr "${feature_branch}" : '.*\(...\).x' | tr -d "."`
	  echo `expr "${dist_branch}" : '.*\(...\).x' | tr -d "."`
      echo "check_feature_branch&check_dist_branch为正常分支"
      if [[ ${check_feature_branch} > ${check_dist_branch} ]]; then
          echo "当前feature_branch高于dist_branch不允许合并"
          exit 1
      else
          echo "当前feature_branch低于等于dist_branch允许合并"
      fi
          echo "检查合并分支结束"
  else
      echo "check_feature_branch&check_dist_branch为特殊分支不做处理！"
  fi
      echo "检查分支特殊性"
}


remote_feature_branch=origin/${feature_branch}
remote_dist_branch=origin/${dist_branch}

function fetch_branch(){

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
    	git clone -b ${feature_branch} ${git_repo}/${project}.git
    else
    	echo "文件夹已经存在"
        cd ${project}
        git fetch origin --prune
        rm -rf remotelist
        rm -rf pulllog
        git branch -a > remotelist
    	if grep -iw "${feature_branch}" remotelist; then
    		echo "========== ${feature_branch} is exist in remote ,please check first ========"
    	else
    		echo "========== ${feature_branch} is not exist in remote ,please check first ========"
        	exit 1
    	fi

        echo "${remote_feature_branch}"
        if [ -n "`git branch -a|grep -E ".*remotes/${remote_feature_branch}$"`" ]; then
        	echo "执行git checkout -f ${remote_feature_branch}"
            git checkout -f ${feature_branch}
            git branch --set-upstream-to=origin/${feature_branch} ${feature_branch}
            git pull > pulllog
            if grep -E "CONFLICT" pulllog;then
            	echo "ERROR: pull分支${feature_branch}存在冲突！！！"
      			rm -rf pulllog
      			git reset --hard ${feature_branch}
      			exit 1
            fi
  		else
  	  		return 1
  		fi
    fi

}

function merge_code(){
  if [ $group == "customltem" ]; then
      cd ${WORKSPACE}/${group}/${project}
      echo "当前路径----"
      pwd
  else
      cd ${WORKSPACE}/${project}
      echo "当前路径----"
      pwd
  fi
    echo "" > mergeout
    echo "源分支：${feature_branch}"
    echo "目标分支：${dist_branch}"
    pwd
    rm -rf pulllog
    git branch -a > remotelist
    if grep -iw "${dist_branch}" remotelist; then
        echo "========== ${dist_branch} is exist in remote ,please check first ========"
    else
        echo "========== ${dist_branch} is not exist in remote ,please check first ========"
        git checkout -b ${dist_branch}
        git push origin ${dist_branch}
    fi

    git branch > branchlist
    echo "============Merge ${feature_branch} 到 ${dist_branch} 分支========"
    if grep -i "${dist_branch}" branchlist; then
    	echo "========== ${dist_branch} is exist ======="
        git checkout ${dist_branch}
        git pull origin ${dist_branch}
    else
    	echo "========== ${dist_branch} is not exist in local ,please check first ========"
        git fetch
        git branch
        git checkout -b ${dist_branch} ${remote_dist_branch}
    fi
    git checkout ${dist_branch}
    git branch --set-upstream-to=origin/${dist_branch} ${dist_branch}
    git pull origin ${dist_branch} >pulllog

    if grep -E "CONFLICT" pulllog;then
    	echo "ERROR: pull分支${dist_branch}存在冲突！！！"
      	rm -rf pulllog
      	git reset --hard ${dist_branch}
      	exit 1
     fi

    git merge ${feature_branch} > mergeout

    echo "Merge结果如下："
    cat mergeout

    rm -rf branchlist
    rm -rf remotelist
    rm -rf pulllog
    if grep -E "CONFLICT" mergeout;then
      echo "ERROR: 请手动合并${feature_branch}到${dist_branch}，因为存在冲突！！！"
      rm -rf mergeout
      git reset --hard origin/${dist_branch}
      exit 1
    else
      echo "===========同步${feature_branch}上的改动到${dist_branch}==========="
      rm -rf mergeout
      git add .
      git commit -m "merge ${feature_branch} to ${dist_branch}"
  	fi

    git log -10

}


function delete_brach(){
	if grep -E "hotfix" ${feature_branch}; then
    	git push origin :${feature_branch}
    fi

    git branch -d ${feature_branch}
    git branch -d ${dist_branch}
}


git_repo=""
project=${project//,/ };
arr=($project);
#遍历数组
for each in ${arr[*]}
do
 	#echo $each
 	project=`echo ${each} |sed 's/\"//g' `
	echo "$group     &   ${project}"

    git_repo="http://gitlab.prod.dtstack.cn/${group}"


 	echo "========STEP1:${project}======"
    check_branch

	echo "========STEP2:checkout ${feature_branch} 代码========"
	#checkout_code
    fetch_branch

	echo "========STEP3:merge ${feature_branch} to ${dist_branch}"
	merge_code

	echo "========STEP4: edit common&service version ====="
	echo "TODO-List"

	echo "========STEP5: push ${dist_branch} to GitLab======="

	git push origin ${dist_branch}

    echo "==========STEP6: ${project} 分支合并结果============="

    git log -10 --graph --oneline --decorate

    echo "==========STEP7: 删除${feature_branch} 分支============="
    #if [ "${delete_feature_branch}" = "true" ];then
     #   	delete_brach
     #   fi

done