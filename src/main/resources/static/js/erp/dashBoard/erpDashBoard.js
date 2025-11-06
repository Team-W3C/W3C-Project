// 대시보드 차트 스크립트

// 주간 예약 현황 차트
function drawWeeklyChart() {
    const canvas = document.getElementById('weeklyChart');
    if (!canvas) return;
    
    const ctx = canvas.getContext('2d');
    const data = [46, 27.625, 38.125, 4, 19.75, 64.375];
    const labels = ['월', '화', '수', '목', '금', '토'];
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
    for (let i = 0; i <= 4; i++) {
        const y = padding.top + (plotHeight / 4) * i;
        ctx.beginPath();
        ctx.moveTo(padding.left, y);
        ctx.lineTo(chartWidth - padding.right, y);
        ctx.stroke();
    }
    
    // 세로선
    for (let i = 0; i <= 5; i++) {
        const x = padding.left + (plotWidth / 5) * i;
        ctx.beginPath();
        ctx.moveTo(x, padding.top);
        ctx.lineTo(x, chartHeight - padding.bottom);
        ctx.stroke();
    }
    
    // 라인 차트 그리기
    ctx.setLineDash([]);
    ctx.strokeStyle = '#0E787C';
    ctx.lineWidth = 2;
    
    const xStep = plotWidth / 5;
    const maxValue = 80;
    
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
        ctx.fillText((20 * i).toString(), padding.left - 10, y + 5);
    }
}

// 장비 이용률 차트
function drawEquipmentChart() {
    const canvas = document.getElementById('equipmentChart');
    if (!canvas) return;
    
    const ctx = canvas.getContext('2d');
    const data = [85, 72, 68, 90, 55];
    const labels = ['MRI', '초음파', 'CT', 'X-Ray', '내시경'];
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
    for (let i = 0; i <= 4; i++) {
        const y = padding.top + (plotHeight / 4) * i;
        ctx.beginPath();
        ctx.moveTo(padding.left, y);
        ctx.lineTo(chartWidth - padding.right, y);
        ctx.stroke();
    }
    
    // 세로선
    for (let i = 0; i <= 5; i++) {
        const x = padding.left + (plotWidth / 5) * i;
        ctx.beginPath();
        ctx.moveTo(x, padding.top);
        ctx.lineTo(x, chartHeight - padding.bottom);
        ctx.stroke();
    }
    
    // 막대 차트 그리기
    ctx.setLineDash([]);
    ctx.fillStyle = '#0E787C';
    
    const barWidth = 60;
    const barSpacing = plotWidth / 5;
    const maxValue = 100;
    
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
        ctx.fillText((25 * i).toString(), padding.left - 10, y + 5);
    }
}

// 환자 등급 분포 도넛 차트 (중앙이 빈 원 그래프)
function drawPatientChart() {
    const canvas = document.getElementById('patientChart');
    if (!canvas) return;
    
    const ctx = canvas.getContext('2d');
    const centerX = 155;
    const centerY = 100;
    const outerRadius = 80;
    const innerRadius = 50; // 도넛 차트를 위한 내부 반지름
    
    // 캔버스 초기화
    ctx.clearRect(0, 0, 311, 200);
    
    const data = [
        { value: 60, color: '#6B7280', label: '일반' },
        { value: 25, color: '#0EA5E9', label: '우선예약' },
        { value: 15, color: '#F59E0B', label: 'VIP' }
    ];
    
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
    drawWeeklyChart();
    drawEquipmentChart();
    drawPatientChart();
});

// 윈도우 리사이즈 시 차트 다시 그리기
window.addEventListener('resize', function() {
    drawWeeklyChart();
    drawEquipmentChart();
    drawPatientChart();
});