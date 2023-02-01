#!/bin/bash

. function.sh

BAR

CODE [U-27] RPC 서비스 확인

cat << EOF >> $result

[양호]: 불필요한 RPC 서비스가 비활성화 되어 있는 경우

[취약]: 불필요한 RPC 서비스가 활성화 되어 있는 경우

EOF

BAR

TMP1=`SCRIPTNAME`.log

>$TMP1  

#!/bin/bash
sudo sed -i 's/rpc.cmsd.*/#&/g' /etc/inetd.conf
sudo service inetutils-inetd restart

# xinetd 일 경우!
# xinetd 디렉토리로 이동
cd /etc/xinetd.d/

# 디렉터리에 있는 모든 파일 나열
files=$(ls)

# 모든 파일을 반복해서 읽다
for file in $files
do
  # vi 편집기에서 파일 열기
  vi $file <<EOF
  # "disable" 라인 찾음
  /disable
  # 값을 "예"로 변경합니다
  cwyes
  # 저장 후 종료
  :wq
EOF
done

# xinetd 서비스 다시 시작
sudo service xinetd restart



cat $result

echo ; echo