package com.w3c.spring.model.vo.inquiry;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PageInfo {
    private int currentPage; //지금 보여줄 페이지(사용자가 요청한 페이지)
    private int listCount; //현재 총 게시글 수
    private int pageLimit; //페이지 버튼을 몇개 보여줄 것인가
    private int boardLimit; //한 페이지에 데이터를 몇개 보여줄 것인가?

    private int maxPage; //가장 마지막페이지가 몇인가?(총 페이지 수)
    private int startPage; //하단에 보여질 페이징 버튼의 시작 수
    private int endPage; //하단에 보여질 페이징 버튼의 마지막 수

    public PageInfo(int currentPage, int listCount, int pageLimit, int boardLimit) {
        super();
        this.currentPage = currentPage;
        this.listCount = listCount;
        this.pageLimit = pageLimit;
        this.boardLimit = boardLimit;

        this.maxPage = (int) Math.ceil((double) this.listCount / this.boardLimit);
        this.startPage = ((this.currentPage - 1) / this.pageLimit) * this.pageLimit + 1;
        this.endPage = this.startPage + this.pageLimit - 1;
        this.endPage = this.endPage > this.maxPage ? this.maxPage : this.endPage;
    }

}