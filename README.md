ECS Fargate 테스트를 sample 프로젝트
---


### 1. 도커라이징

```bash
docker build -t hello:1.0.0 . 
docker run -d -p 8000:8000 --name hello hello:1.0.0
```


### 2. ECR 푸시

```bash
sh ./deploy.sh
```


### 3. ECS Fargate 구성

(Tip) github-action 적용을 고려해서 이름을 동일하게 한다 

1. ECS Cluster 생성 (STG)
2. ECS Task 정의 (hello-stg)
    - 컨테이너 이름 (hello-stg)
3. ELB 생성 (STG) 
    - 보안그룹 생성
    - 타켓그룹 생성 후 삭제
4. ECS Service 생성 (hello-stg)
    - 보안그룹 생성
    - 타켓그룹 생성
