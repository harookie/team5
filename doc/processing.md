
### kubenetes namespace 생성
아래 yaml 파일 내용으로 namespace를 생성한다.

```yaml
apiVersion: v1
kind: Namespace
metadata:
  labels:
    kubernetes.io/metadata.name: group1-team5
  name: group1-team5
```

```shell
[eva@k8s-vga-master resource]$ kubectl apply -f /home/eva/user/group1/team5/resource/namespace.yaml
```

### 기본 서비스 상태 확인
Docker 데몬이 실행 중인지 확인 
docker daemon이 실행중인 k8s-vgs-master에서 수행
```shell
systemctl status docker
```
Local Registry 확인

```text
curl -X GET http://k8s-vga-worker1:5000/v2/_catalog
```

### jenkins 추가 설정
Jenkins 실행 계정이 docker 명령을 실행할 수 있도록 그룹에 추가후 서비스 재시작 필요
```shell
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins
```

### mvn command 설치
mvn 버전이 낮아 jar 패키징 실패시 mvn update 필요
```
sudo yum install maven
mvn -version
```

위 명령으로 진행 했으니, 운영체제의 버전이 낮아 mvn도 버전이 낮음.

최신 Maven 다운로드
```text
cd /usr/local
sudo wget https://downloads.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz
```

```text
sudo tar -xvzf apache-maven-3.9.6-bin.tar.gz
sudo mv apache-maven-3.9.6 /usr/local/maven
```

기존 명령어 바이너리 백업 및 soft link 생성
```text
sudo /bin/mvn /bin/mvn_backup
sudo ln -s /usr/local/maven/bin/mvn /bin/mvn
sudo mvn -version
```

버전 확인 결과 
```text
Apache Maven 3.9.6 (bc0240f3c744dd6b6ec2920b3cd08dcc295161ae)
Maven home: /usr/local/maven
Java version: 1.8.0_402, vendor: Red Hat, Inc., runtime: /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.402.b06-1.el7_9.x86_64/jre
Default locale: ko_KR, platform encoding: UTF-8
OS name: "linux", version: "3.10.0-1160.99.1.el7.x86_64", arch: "amd64", family: "unix"
```

### jenkins에서 kubectl 명령어 실패시 조치
정상 동작중인 기본 계정(여기서는 eva)의 ~/.kube/config 파일을  
jenkins 계정의 홈디렉토 하위로 복제하는 과정 필요  

```text
sudo cp /home/eva/.kube/config /var/lib/jenkins/.kube/config
sudo chown -R jenkins:jenkins /var/lib/jenkins/.kube
sudo chmod 600 /var/lib/jenkins/.kube/config
```
