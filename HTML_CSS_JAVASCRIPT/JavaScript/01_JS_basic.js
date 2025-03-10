// 웹브라우저 콘솔에 id가 title인 태그 출력
const title = document.querySelector("#title");
console.log(title);

// 링크 클릭 이벤트 연결하기
const link = document.querySelector("a");
// link.addEventListener("click", () => {
//     console.log("링크를 클릭했습니다.");
// })

// 링크를 클릭해도 링크가 작동되지 않고
// console.log만 작동되도록 preventDefault()
link.addEventListener("click", (e) => {
  e.preventDefault();
  console.log("링크를 클릭했습니다.");
});

// HTML 요소에 마우스 이벤트 연결하기
const box = document.querySelector("#box");

box.addEventListener("mouseenter", () => {
  box.style.backgroundColor = "pink";
});

box.addEventListener("mouseleave", () => {
  box.style.backgroundColor = "lightblue";
});

// 반복되는 요소에 이벤트 한번에 연결하기
const list = document.querySelectorAll(".list li");
console.log(list);

for (let el of list) {
  el.addEventListener("click", (e) => {
    e.preventDefault();
    console.log(e.currentTarget.innerText);
  });
}

// 클릭 이벤트가 발생할 때 숫자 증가, 감소하기
const btnPlus = document.querySelector(".btnPlus");
const btnMinus = document.querySelector(".btnMinus");

let num = 0; // 제어할 숫자값을 0으로 초기화

// btnPlus를 클릭할 때
btnPlus.addEventListener("click", (e) => {
  e.preventDefault();
  num++;
  console.log("숫자 : " + num);
});

// btnMinus를 클릭할 때
btnMinus.addEventListener("click", (e) => {
  e.preventDefault();
  num--;
  console.log("숫자 : " + num);
});

//   버튼을 클릭하면 좌우로 회전하는 박스 만들기
const btnRotateL = document.querySelector(".btnLeft");
const btnRotateR = document.querySelector(".btnRight");
const box2 = document.querySelector("#box2");
const deg = 45; // 회전할 각도
let num2 = 0; // 클릭 수

// btnLeft를 클릭할 때
btnRotateL.addEventListener("click", (e) => {
  e.preventDefault();
  num2--;
  console.log(`num2 : ${num2}`);
  box2.style.transform = `rotate(${num2 * deg}deg)`;
});

// btnRight를 클릭할 때
btnRotateR.addEventListener("click", (e) => {
  e.preventDefault();
  num2++;
  console.log(`num2 : ${num2}`);
  box2.style.transform = `rotate(${num2 * deg}deg)`;
});
