// 달력 생성
const makeCalendar = (date) => {
    // 현재의 년도와 월 받아오기
    const nowYear = new Date(date).getFullYear();
    const nowMonth = new Date(date).getMonth() + 1;

    // 지난달의 마지막 요일
    const prevDay = new Date(nowYear, nowMonth - 1, 1).getDay();

    // 현재 월의 마지막 날 구하기
    const lastDay = new Date(nowYear, nowMonth, 0).getDate();

    // 남은 박스만큼 다음달 날짜 표시
    const limitDay = prevDay + lastDay;
    const nextDay = Math.ceil(limitDay / 7) * 7;

    let htmlDummy = '';

    // 전달 날짜 표시하기
    for (let i = 0; i < prevDay; i++) {
        htmlDummy += `<div class="cal-noColor"></div>`;
    }

    // 현재 날짜 표시하기
    for (let i = 1; i <= lastDay; i++) {
        htmlDummy += `<div>${i}</div>`;
    }

    // 다음달 날짜 표시하기
    for (let i = limitDay; i < nextDay; i++) {
        htmlDummy += `<div class="cal-noColor"></div>`;
    }

    document.querySelector(`.cal-dateBoard`).innerHTML = htmlDummy;
    document.querySelector(`.cal-dateTitle`).innerText = `${nowYear}년 ${nowMonth}월`;
}


const date = new Date();

makeCalendar(date);

// 이전달 이동
document.querySelector(`.cal-prevDay`).onclick = () => {
    makeCalendar(new Date(date.setMonth(date.getMonth() - 1)));
}

// 다음달 이동
document.querySelector(`.cal-nextDay`).onclick = () => {
    makeCalendar(new Date(date.setMonth(date.getMonth() + 1)));
}
function inputPlan(arr){
    console.log(arr)
    for (let i = 0;i<arr.length; i++){
        var plNo = arr[i].plNo;
        var day=new Date(arr[i].plDate).getDate();
        var gName = arr[i].gName;
        var plCont = arr[i].plCont;
        var plTitle = arr[i].plTitle;
		
        var plTag = '<a onclick="plDetail('+plNo+');"><p>모임명 : '+gName+'</p>'
                +'<p>일정명 : '+plTitle+'</p>'
        
        var div = document.getElementById("current"+day);
        div.innerHTML += pTag;
    }
}

function inputChal(arr){
    console.log(arr)
    for (let i = 0;i<arr.length; i++){
        var cNo = arr[i].cNo;
        var day = new Date(arr[i].cDate).getDate();
        var gName = arr[i].gName;
        var cCont = arr[i].cCont;
        var cTitle = arr[i].cTitle;

        var cTag = '<a onclick="cDetail('+cNo+');"><p>모임명 : '+gName+'</p>'
        +'<p>일정명 : '+cTitle+'</p>'

        var div = document.getElementById("current"+day);
        div.innerHTML += cTag;
    }
}