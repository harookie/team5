
### kubenetes namespace 생성
아래 yaml 파일 내용으로 namespace를 생성한다.

```yaml
apiVersion: v1
kind: Namespace
metadata:
  labels:
    kubernetes.io/metadata.name: team5
  name: team5
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
local registry가 메일에는 `k8s-vga-worker1:5000`에 설치됐다고 했지만, 실제로는 k8s-vga-master:5000에서 서비스 하고 있음.
```text
curl -X GET http://k8s-vga-master:5000/v2/_catalog
```

### jenkins 추가 설정
Jenkins 실행 계정이 docker 명령을 실행할 수 있도록 그룹에 추가후 서비스 재시작 필요
```shell
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins
```

### mvn command 설치
```
sudo yum install maven
```




