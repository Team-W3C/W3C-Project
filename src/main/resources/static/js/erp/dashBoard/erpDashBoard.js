// 대시보드 차트 스크립트

// 주간 예약 현황 차트
function drawWeeklyChart(data) {
    const canvas = document.getElementById('weeklyChart');
    if (!canvas) return;

    const ctx = canvas.getContext('2d');
    const labels = ['월', '화', '수', '목', '금', '토','일'];
    const chartWidth = 503;
    const chartHeight = 250;
    const padding = { left: 65, top: 20, right: 20, bottom: 40 };
    const plotWidth = chartWidth - padding.left - padding.right;
    const plotHeight = chartHeight - padding.top - padding.bottom;

    // 캔버스 초기화
    ctx.clearRect(0, 0, chartWidth, chartHeight);

    // 그리드 그리기
    ctx.strokeStyle = '#E5E7EB';
    ctx.setLineDash([3, 3]);
    ctx.lineWidth = 1;

    // 가로선
    for (let i = 0; i <= 5; i++) {
        const y = padding.top + (plotHeight / 5) * i;
        ctx.beginPath();
        ctx.moveTo(padding.left, y);
        ctx.lineTo(chartWidth - padding.right, y);
        ctx.stroke();
    }

    // 세로선
    for (let i = 0; i <= 6; i++) {
        const x = padding.left + (plotWidth / 6) * i;
        ctx.beginPath();
        ctx.moveTo(x, padding.top);
        ctx.lineTo(x, chartHeight - padding.bottom);
        ctx.stroke();
    }

    // 라인 차트 그리기
    ctx.setLineDash([]);
    ctx.strokeStyle = '#0E787C';
    ctx.lineWidth = 2;

    const xStep = plotWidth / 6;
    const rawMax = Math.max(...data);      // 데이터 중 최고값
    const maxValue = Math.ceil(rawMax / 5) * 5; // 보기 좋게 5 단위로 올림 (17 → 20)
    const steps = 4;
    ctx.beginPath();
    data.forEach((value, index) => {
        const x = padding.left + xStep * index;
        const y = chartHeight - padding.bottom - (value / maxValue) * plotHeight;

        if (index === 0) {
            ctx.moveTo(x, y);
        } else {
            ctx.lineTo(x, y);
        }
    });
    ctx.stroke();

    // 데이터 포인트 그리기
    data.forEach((value, index) => {
        const x = padding.left + xStep * index;
        const y = chartHeight - padding.bottom - (value / maxValue) * plotHeight;

        ctx.fillStyle = 'white';
        ctx.strokeStyle = '#0E787C';
        ctx.lineWidth = 2;
        ctx.beginPath();
        ctx.arc(x, y, 4, 0, Math.PI * 2);
        ctx.fill();
        ctx.stroke();
    });

    // X축 레이블
    ctx.fillStyle = '#6B7280';
    ctx.font = '12px Arial';
    ctx.textAlign = 'center';
    labels.forEach((label, index) => {
        const x = padding.left + xStep * index;
        ctx.fillText(label, x, chartHeight - 15);
    });

    // Y축 레이블
    ctx.textAlign = 'right';
    for (let i = 0; i <= 4; i++) {
        const y = chartHeight - padding.bottom - (plotHeight / 4) * i;
        const labelValue = Math.round((maxValue / steps) * i);
        ctx.fillText(labelValue.toString(), padding.left - 10, y + 5);
    }
}

// 장비 이용률 차트
function drawEquipmentChart(data, labels) {
    const canvas = document.getElementById('equipmentChart');
    if (!canvas) return;

    const ctx = canvas.getContext('2d');
    const chartWidth = 503;
    const chartHeight = 250;
    const padding = { left: 65, top: 20, right: 20, bottom: 40 };
    const plotWidth = chartWidth - padding.left - padding.right;
    const plotHeight = chartHeight - padding.top - padding.bottom;

    // 캔버스 초기화
    ctx.clearRect(0, 0, chartWidth, chartHeight);

    // 그리드 그리기
    ctx.strokeStyle = '#E5E7EB';
    ctx.setLineDash([3, 3]);
    ctx.lineWidth = 1;

    for (let i = 0; i <= 4; i++) {
        const y = padding.top + (plotHeight / 4) * i;
        ctx.beginPath();
        ctx.moveTo(padding.left, y);
        ctx.lineTo(chartWidth - padding.right, y);
        ctx.stroke();
    }

    for (let i = 0; i <= 5; i++) {
        const x = padding.left + (plotWidth / 5) * i;
        ctx.beginPath();
        ctx.moveTo(x, padding.top);
        ctx.lineTo(x, chartHeight - padding.bottom);
        ctx.stroke();
    }


    const rawMax = Math.max(...data);         // 데이터 중 최고값
    const maxValue = Math.ceil(rawMax / 5) * 5 || 5;
    // 최소값 5로 설정 (전부 0이면 0 나오는 문제 방지)

    // 막대 차트 그리기
    ctx.setLineDash([]);
    ctx.fillStyle = '#0E787C';

    const barWidth = 60;
    const barSpacing = plotWidth / 5;

    data.forEach((value, index) => {
        const x = padding.left + barSpacing * index + (barSpacing - barWidth) / 2;
        const height = (value / maxValue) * plotHeight;
        const y = chartHeight - padding.bottom - height;

        ctx.fillRect(x, y, barWidth, height);
    });

    // X축 레이블
    ctx.fillStyle = '#6B7280';
    ctx.font = '12px Arial';
    ctx.textAlign = 'center';
    labels.forEach((label, index) => {
        const x = padding.left + barSpacing * index + barSpacing / 2;
        ctx.fillText(label, x, chartHeight - 15);
    });

    // Y축 레이블
    ctx.textAlign = 'right';
    for (let i = 0; i <= 4; i++) {
        const y = chartHeight - padding.bottom - (plotHeight / 4) * i;
        const labelValue = Math.round((maxValue / 4) * i);
        ctx.fillText(labelValue.toString(), padding.left - 10, y + 5);
    }
}

// 환자 등급 분포 도넛 차트 (중앙이 빈 원 그래프)
function drawPatientChart(data) {
    const canvas = document.getElementById('patientChart');
    if (!canvas) return;
    
    const ctx = canvas.getContext('2d');
    const centerX = 155;
    const centerY = 100;
    const outerRadius = 80;
    const innerRadius = 50; // 도넛 차트를 위한 내부 반지름
    
    // 캔버스 초기화
    ctx.clearRect(0, 0, 311, 200);
    
    // const data = [
    //     { value: 60, color: '#6B7280', label: '일반' },
    //     { value: 25, color: '#0EA5E9', label: '우선예약' },
    //     { value: 15, color: '#F59E0B', label: 'VIP' }
    // ];
    
    let currentAngle = -Math.PI / 2;
    
    // 도넛 차트 그리기
    data.forEach(segment => {
        const sliceAngle = (segment.value / 100) * 2 * Math.PI;
        
        // 외부 원호
        ctx.beginPath();
        ctx.arc(centerX, centerY, outerRadius, currentAngle, currentAngle + sliceAngle);
        ctx.arc(centerX, centerY, innerRadius, currentAngle + sliceAngle, currentAngle, true);
        ctx.closePath();
        ctx.fillStyle = segment.color;
        ctx.fill();
        
        // 테두리
        ctx.strokeStyle = 'white';
        ctx.lineWidth = 2;
        ctx.stroke();
        
        currentAngle += sliceAngle;
    });
    
    // 중앙 원 (흰색으로 덮어서 도넛 모양 만들기)
    ctx.beginPath();
    ctx.arc(centerX, centerY, innerRadius, 0, Math.PI * 2);
    ctx.fillStyle = 'white';
    ctx.fill();
}

// 페이지 로드 시 모든 차트 그리기
document.addEventListener('DOMContentLoaded', function() {
    loadWeeklyChart();
    loadFacilityChart();
    loadGradeChart()
});


// 윈도우 리사이즈 시 차트 다시 그리기
window.addEventListener('resize', function() {
    loadWeeklyChart();
    loadFacilityChart();
    loadGradeChart()
});

function loadWeeklyChart() {
    fetch("/api/erp/chart/reservation")
        .then(res => {
            if (!res.ok) {
                throw new Error(`서버 오류: ${res.status} ${res.statusText}`);
            }
            return res.json();
        })
        .then(data => {
            console.log(data);
            drawWeeklyChart(data);
        })
        .catch(err => {
            console.error('주간 예약 차트 로드 실패:', err);
        })
        .finally(() => {
            console.log('주간 예약 차트 요청 완료');
        });
}
function loadGradeChart() {
    fetch("/api/erp/chart/grade")
        .then(res => res.json())
        .then(apiData => {

            const colors = {
                "일반": "#6B7280",
                "우선예약": "#0EA5E9",
                "VIP": "#F59E0B"
            };

            const data = apiData.map(item => ({
                label: item.label,
                value: item.value,
                color: colors[item.label]
            }));

            drawPatientChart(data);
            updateLegend(apiData);
        })
        .catch(err => console.error(err));
}
function updateLegend(apiData) {

    apiData.forEach(item => {
        const grade = item.label;
        const ratio = item.value + "%";

        if (grade === "일반") {
            document.querySelector(".nomarl_val").textContent = ratio;
        }
        else if (grade === "우선예약") {
            document.querySelector(".first_val").textContent = ratio;
        }
        else if (grade === "VIP") {
            const vipItem = document.querySelector(".vip_val").closest(".legend-item");
            vipItem.querySelector(".legend-item__value").textContent = ratio;
        }
    });


}
function loadFacilityChart() {
    fetch("/api/erp/chart/facility")
        .then(res => res.json())
        .then(result => {
            console.log("데이터 "+result.data);
            drawEquipmentChart(result.data, result.labels);
        })
        .catch(err => console.error("시설 예약 차트 로드 실패:", err));
}