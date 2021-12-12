## Bài tập về nhà nâng cấp dự án Obo Stadium của Nguyễn Duy Thái Sơn

Các bước em đã làm:

- Em đã điều chỉnh docker-compose.yml một chút:
  - Tạo một private network dạng bridge giữa container của MySQL và web app xong chỉ expose web ra localhost
  - Bổ sung một số biến môi trường và điều chỉnh application-dev.yml thích ứng để nhận giá trị biến môi trường hoặc default ngay cạnh
- Chạy app bằng lệnh docker-compose -f docker-compose.yml up -d
- Tuy nhiên khi dùng maven:latest thì em build rất tốn thời gian và gặp phải lỗi:


<img width="960" alt="build_maven_latest" src="https://user-images.githubusercontent.com/94212764/145722014-6f909fd4-32bb-4fda-9e70-fab8fdb239b6.png">


<img width="960" alt="build_maven_latest_2" src="https://user-images.githubusercontent.com/94212764/145722036-d70e645e-ed2f-4fe5-80c6-da8fd84cd930.png">


- Sau đó em đã lên DockerHub để tìm image nhẹ hơn cho maven, và em quyết định dùng 

