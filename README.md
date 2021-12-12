## Bài tập về nhà nâng cấp dự án Obo Stadium của Nguyễn Duy Thái Sơn

Các bước em đã làm:

- Em đã điều chỉnh docker-compose.yml một chút:
  - Tạo một private network dạng bridge giữa container của MySQL và web app xong chỉ expose web ra localhost
  - Bổ sung một số biến môi trường và điều chỉnh application-dev.yml thích ứng để nhận giá trị biến môi trường hoặc default ngay cạnh
- Chạy app bằng lệnh docker-compose -f docker-compose.yml up -d
- Tuy nhiên khi dùng maven:latest thì em build rất tốn thời gian và gặp phải lỗi:


<img width="960" alt="build_maven_latest" src="https://user-images.githubusercontent.com/94212764/145722014-6f909fd4-32bb-4fda-9e70-fab8fdb239b6.png">


<img width="960" alt="build_maven_latest_2" src="https://user-images.githubusercontent.com/94212764/145722036-d70e645e-ed2f-4fe5-80c6-da8fd84cd930.png">

- Sau đó em nâng phiên bản Spring lên 2.6.1 và Java lên 17 trong pom.xml như đề bài yêu cầu
- Tiếp theo em lên DockerHub để tìm image nhẹ hơn cho maven, và em quyết định dùng maven:3.8-openjdk-17-slim (nhẹ hơn gần một nửa, latest nặng hơn 400gb, còn bản slim này nặng khoảng 220gb)
- Em tạo một file .dockerignore và đổi Dockerfile từ single stage build sang multi stage build nhằm tối ưu kích cỡ cho image
- Tuy nhiên lúc này build vẫn lỗi, mà chạy docker-compose không hiện full stack trace, nên em chạy Dockerfile và hóa ra lỗi là như sau:

<img width="960" alt="docker_no_spring_val" src="https://user-images.githubusercontent.com/94212764/145722257-afee84e0-a4eb-424e-b11c-63a6f7dfcecd.png">

- Nguyên nhân là do thiếu thư viện Spring Validation. Rất may trước đó em đã [viết bài về Spring Validation]((https://techmaster.vn/posts/36877/xac-thuc-request-bang-spring-boot-validation).) nên biết được là từ Spring Boot 2.3 trở đi thư viện validation không được bao gồm trong spring-boot-starter-parent nữa, mà mình vừa thực hiện nâng project từ Spring 2.1 lên Spring 2.6.1.
- Sau đó em giải quyết các Spring và một vài dependency còn thiếu:
<img width="690" alt="docker_no_dom4j" src="https://user-images.githubusercontent.com/94212764/145722455-02e5463d-5a8f-4f9d-87ae-dd7ea9a71269.png">

- Em chạy docker-compose down để xóa hết các image cũ rồi chạy lại lệnh up bên trên thì thành công:
<img width="960" alt="result" src="https://user-images.githubusercontent.com/94212764/145722559-f49f48ee-014d-4df7-8415-b59c7918fe3b.png">

- Đây là kích thước của container sau khi tối ưu ạ:
<img width="960" alt="docker_size_after_opt" src="https://user-images.githubusercontent.com/94212764/145722570-ab1094cd-d505-442c-abf7-feb9d01eddf7.PNG">

Em cảm ơn thầy đã đọc bài.
