#!/bin/bash

curl_path=""
curl_url="http://localhost:8085/generateData"

function curl_http() {
    curl -X GET $curl_url
}

curl_http