# 보안 조치 자동화 - ubuntu 버전

이 프로젝트는 CentOS 리눅스 시스템의 취약점을 자동으로 진단하고 조치하는 쉘 스크립트를 개발하는 것을 목표로 합니다.

## 프로젝트 개요

- **목적**: CentOS 리눅스의 설정 파일 취약점을 자동으로 진단 및 조치
- **프로젝트 기간**: 2023년 1월 ~ 2023년 2월

## 역할

본 프로젝트에서 제 역할은 다음과 같습니다:

- 취약점 진단을 위한 쉘 스크립트 개발
- 취약점 조치 및 복구 스크립트 검증
- 시스템 보안 강화를 위한 자동화 스크립트 구현

## 프로젝트 성과

이 프로젝트를 통해 다음과 같은 성과를 달성했습니다:

- CentOS 리눅스 시스템의 주요 취약점 자동 진단 및 조치 구현
- 주요통신기반시설 취약점 가이드를 기반으로 한 시스템 보안 수준 향상

## 사용 방법

스크립트를 사용하기 위해서는 리눅스 터미널에서 다음과 같은 명령어를 입력합니다:

```bash
git clone https://github.com/971023als/centos-vul.git
cd centos-vul
chmod +x diagnose.sh
./diagnose.sh

