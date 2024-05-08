#!/bin/bash

# ファイルのハッシュ値を計算しファイル出力するスクリプト
function calc_hash() {
  # 第一引数、第二引数が指定されていない場合はエラーを出力して終了
  if [ $# -ne 2 ]; then
    echo "usage: calc_hash <directory> <output_file>"
    exit 1
  fi

  >$2

  # 第一引数は調べる対象のディレクトリとする
  for file in "$1"/{*.ts,package*.json}; do
    sha256sum $file | cut -f 1 -d " " >>$2
  done
}

HASH_FILE=./sha256sum.txt
TMP_FILE=./__tmp_sha256sum__.txt
LAMBDA_DIR=./lambda

calc_hash $LAMBDA_DIR $TMP_FILE

# sha265sum.txt が存在していて、且つ、ハッシュ値が同じ場合は何もしない
if [ -e sha256sum.txt ] && cmp -s $HASH_FILE $TMP_FILE ; then
  rm $TMP_FILE
  exit 0
fi

# 上の否定 = ( ハッシュが存在しない || ハッシュが違う )
rm $TMP_FILE

calc_hash $LAMBDA_DIR $HASH_FILE
cd $LAMBDA_DIR
npm ci
npm run build
