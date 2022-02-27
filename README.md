# README

### 초기 화면 / `초기화하기` 클릭 시 화면
* `Previous` 클릭 시 이전 주(week)가 보여지고, `Next` 클릭 시 다음 주(week)가 보여진다.
* `Previous`와 `Next` 버튼 사이에는 현재 보여지는 주의 일요일이 속한 연(year), 월(month)이 나타난다.
<kbd>
<img width="500" alt="스크린샷 2022-02-27 오후 2 16 02" src="https://user-images.githubusercontent.com/39628758/155869195-d5d790f5-4376-4bf0-ae62-f4fd21127b8f.png">
</kbd>

### `Mock Data로 초기화하기` 클릭 시 화면
* 캘린더에 임의의 schedule들이 불러와진다.
* `1(o)`는 tutor(id:1)가 해당 날짜-시간에 교습이 가능함을 의미한다.
* `2(x)`는 tutor(id:2)가 해당 날짜-시간에 교습이 불가능함을 의미한다.
<kbd>
<img width="500" alt="스크린샷 2022-02-27 오후 2 16 14" src="https://user-images.githubusercontent.com/39628758/155869203-6870486a-fa2e-42ca-a55f-e69aaee45e1a.png">
</kbd>

### `20분` 수강권 클릭 시
* 캘린더에 표시된 schedule들 중 **교습 가능한 튜터가 존재**하는 시간대에만 셀이 녹색으로 칠해진다.
<kbd>
<img width="500" alt="스크린샷 2022-02-27 오후 2 17 24" src="https://user-images.githubusercontent.com/39628758/155869229-ce14bc56-288a-41b8-8128-4c92cac072ea.png">
</kbd>

### `40분` 수강권 클릭 시
* 캘린더에 표시된 schedule들 중 **이웃한 두 시간대 동안 교습 가능한 튜터가 존재**할 경우, 그 시작 시간대에만 셀이 녹색으로 칠해진다.
* 예를 들어 3월 3일 목요일에는 tutor(id:5)가 00:00시부터 01:00시까지 교습 가능하고, tutor(id:6)이 00:30시부터 02:00까지 교습 가능하다.
* 이 경우 tutor(id:5)에게 00시부터 40분동안 교습받는 것이 가능하고, tutor(id:6)에게는 00:30/01:00시부터 40분동안 교습받는 것이 가능하다.
<kbd>
  <img width="500" alt="스크린샷 2022-02-27 오후 2 52 49" src="https://user-images.githubusercontent.com/39628758/155870099-25218979-ae1b-4670-8d29-3faffd5224bc.png">
</kbd>

백신 아파.......
생각보다 프론트에서 삽질하는 데에 시간을 많이 써버렸다.... TOT
