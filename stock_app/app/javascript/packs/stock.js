//Created 7/30/2022 by Noah Moon
let year = document.getElementById("year")
let month = document.getElementById("month")
let threeMonth = document.getElementById("threeMonth")
let monthButton = document.getElementById("monthButton")
let threeMonthButton = document.getElementById("threeMonthButton")
let yearButton = document.getElementById("yearButton")
function hideYear(){
        year.style.visibility = "hidden";
        yearButton.style.backgroundColor = "white"
        yearButton.style.color = "black"
}
function hideMonth(){
        month.style.visibility = "hidden";
        monthButton.style.backgroundColor = "white"
        monthButton.style.color = "black"
}
function hideThreeMonth(){
        threeMonth.style.visibility = "hidden";
        threeMonthButton.style.backgroundColor = "white"
        threeMonthButton.style.color = "black"
}
function showYear(){
        year.style.visibility = "visible";
        yearButton.style.backgroundColor = "#068e1b"
        yearButton.style.color = "white"
}
function showMonth(){
        month.style.visibility = "visible";
        monthButton.style.backgroundColor = "#068e1b"
        monthButton.style.color = "white"
}
function showThreeMonth(){
        threeMonth.style.visibility = "visible";
        threeMonthButton.style.backgroundColor = "#068e1b"
        threeMonthButton.style.color = "white"
}
function monthClick(){
        showMonth()
        hideYear()
        hideThreeMonth()
}
function threeMonthClick(){
        showThreeMonth()
        hideYear()
        hideMonth()
}
function yearClick(){
        hideMonth()
        hideThreeMonth()
        showYear()

}


monthButton.addEventListener("click", monthClick);
threeMonthButton.addEventListener("click", threeMonthClick);
yearButton.addEventListener("click", yearClick);
monthClick();