// MediFlow Landing Page JavaScript

// 페이지 로드 완료 후 실행
document.addEventListener('DOMContentLoaded', () => {
    console.log('MediFlow 랜딩페이지 로드 완료');
    
    // 약간의 지연 후 이벤트 리스너 등록 (HTML 인클루드 완료 대기)
    setTimeout(() => {
        initializeEventListeners();
        initializeAnimations();
    }, 100);
});

// 이벤트 리스너 초기화
function initializeEventListeners() {
    // 네비게이션 링크
    const navLinks = document.querySelectorAll('.nav-link');
    navLinks.forEach(link => {
        link.addEventListener('click', handleNavClick);
    });

    // Hero 버튼
    const ctaButton = document.querySelector('.cta-button');
    if (ctaButton) {
        ctaButton.addEventListener('click', handleCtaClick);
    }

    // 서비스 카드
    const serviceCards = document.querySelectorAll('.service-card');
    serviceCards.forEach(card => {
        card.addEventListener('click', handleServiceCardClick);
    });

    // 공지사항 아이템
    const announcementItems = document.querySelectorAll('.announcement-item');
    announcementItems.forEach(item => {
        item.addEventListener('click', handleAnnouncementClick);
    });

    // Footer 버튼
    const footerButton = document.querySelector('.footer-button');
    if (footerButton) {
        footerButton.addEventListener('click', handleFooterButtonClick);
    }

    // 소셜 아이콘
    const socialIcons = document.querySelectorAll('.social-icon');
    socialIcons.forEach(icon => {
        icon.addEventListener('click', handleSocialIconClick);
    });

    // 스크롤 이벤트
    window.addEventListener('scroll', handleScroll);
}

// 네비게이션 클릭 핸들러
function handleNavClick(e) {
    e.preventDefault();
    const text = this.textContent.trim();
    console.log(`${text} 메뉴 클릭됨`);
    
    if (text === '대시보드') {
        alert('대시보드 페이지로 이동합니다.');
        // 실제 구현: window.location.href = '/dashboard';
    } else {
        alert(`${text} 페이지로 이동합니다.`);
    }
}

// CTA 버튼 클릭 핸들러
function handleCtaClick() {
    console.log('자세히 보기 클릭');
    alert('MediFlow에 대한 자세한 정보 페이지로 이동합니다.');
    // 실제 구현: window.location.href = '/about';
}

// 서비스 카드 클릭 핸들러
function handleServiceCardClick() {
    const serviceName = this.querySelector('.service-name').textContent;
    console.log(`${serviceName} 서비스 선택됨`);
    alert(`${serviceName} 서비스 페이지로 이동합니다.`);
    // 실제 구현: window.location.href = '/service/' + serviceId;
}

// 공지사항 클릭 핸들러
function handleAnnouncementClick() {
    const text = this.querySelector('.announcement-text').textContent;
    const date = this.querySelector('.announcement-date').textContent;
    console.log(`공지사항 클릭: ${text}`);
    alert(`${text}\n날짜: ${date}`);
    // 실제 구현: window.location.href = '/notice/' + noticeId;
}

// Footer 버튼 클릭 핸들러
function handleFooterButtonClick() {
    console.log('문의사항 페이지로 이동');
    alert('문의사항 페이지로 이동합니다.');
    // 실제 구현: window.location.href = '/inquiry';
}

// 소셜 아이콘 클릭 핸들러
function handleSocialIconClick(e) {
    e.preventDefault();
    const platform = this.getAttribute('aria-label');
    console.log(`${platform} 소셜 미디어 링크 클릭`);
    alert(`${platform} 페이지로 이동합니다.`);
    // 실제 구현: window.open(socialMediaUrl, '_blank');
}

// 스크롤 핸들러
let lastScroll = 0;
function handleScroll() {
    const header = document.querySelector('.header');
    const currentScroll = window.pageYOffset;
    
    // 헤더 그림자 효과
    if (currentScroll > 100) {
        header.style.boxShadow = '0 2px 10px rgba(0,0,0,0.15)';
    } else {
        header.style.boxShadow = '0 2px 4px rgba(0,0,0,0.1)';
    }
    
    lastScroll = currentScroll;
}

// 애니메이션 초기화
function initializeAnimations() {
    // Hero 섹션 페이드인
    const hero = document.querySelector('.hero');
    if (hero) {
        hero.style.opacity = '0';
        hero.style.transform = 'translateY(20px)';
        
        setTimeout(() => {
            hero.style.transition = 'opacity 0.8s ease, transform 0.8s ease';
            hero.style.opacity = '1';
            hero.style.transform = 'translateY(0)';
        }, 200);
    }

    // 서비스 카드 스크롤 애니메이션
    const serviceCards = document.querySelectorAll('.service-card');
    const observerOptions = {
        threshold: 0.15,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach((entry, index) => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '0';
                entry.target.style.transform = 'translateY(30px)';
                
                setTimeout(() => {
                    entry.target.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                }, 100 * index);
                
                observer.unobserve(entry.target);
            }
        });
    }, observerOptions);

    serviceCards.forEach(card => {
        observer.observe(card);
    });

    // 공지사항 섹션 애니메이션
    const announcements = document.querySelector('.announcements');
    if (announcements) {
        observer.observe(announcements);
    }
}

// 유틸리티: 부드러운 스크롤
function smoothScrollTo(element, duration = 1000) {
    const targetPosition = element.getBoundingClientRect().top + window.pageYOffset;
    const startPosition = window.pageYOffset;
    const distance = targetPosition - startPosition;
    let startTime = null;

    function animation(currentTime) {
        if (startTime === null) startTime = currentTime;
        const timeElapsed = currentTime - startTime;
        const run = easeInOutQuad(timeElapsed, startPosition, distance, duration);
        window.scrollTo(0, run);
        if (timeElapsed < duration) requestAnimationFrame(animation);
    }

    function easeInOutQuad(t, b, c, d) {
        t /= d / 2;
        if (t < 1) return c / 2 * t * t + b;
        t--;
        return -c / 2 * (t * (t - 2) - 1) + b;
    }

    requestAnimationFrame(animation);
}

// 페이지 전체 페이드인
document.body.style.opacity = '0';
window.addEventListener('load', () => {
    setTimeout(() => {
        document.body.style.transition = 'opacity 0.5s ease';
        document.body.style.opacity = '1';
    }, 100);
});

// Export (모듈 사용시)
if (typeof module !== 'undefined' && module.exports) {
    module.exports = {
        smoothScrollTo,
        initializeEventListeners,
        initializeAnimations
    };
}