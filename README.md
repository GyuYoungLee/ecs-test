ECS Fargate 테스트를 sample 프로젝트
---

---
### 로컬 테스트

```bash
docker build -t hello:1.0.0 . 
docker run -d -p 8000:8000 --name hello hello:1.0.0
```
<br>

### ECR 푸시

```bash
aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin
393364682658.dkr.ecr.ap-northeast-2.amazonaws.com 
docker build --platform linux/amd64 -t stg/hello .
docker tag stg/hello:latest 393364682658.dkr.ecr.ap-northeast-2.amazonaws.com/stg/hello:latest
docker push 393364682658.dkr.ecr.ap-northeast-2.amazonaws.com/stg/hello:latest
```

<br>

---
### ECS Fargate 구성 절차

(Tip) github-action 적용을 고려해서 이름을 동일하게 한다 

1. ECS Cluster 생성 (STG)
2. ECR 생성
3. ECS Task 정의 (hello-stg)
    - 컨테이너 이름 (hello-stg)
4. ELB 생성 (STG) 
    - 보안그룹 생성
    - 타켓그룹 생성 후 삭제
5. ECS Service 생성 (hello-stg)
    - 보안그룹 생성
    - 타켓그룹 생성

---