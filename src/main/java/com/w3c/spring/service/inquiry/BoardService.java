package com.w3c.spring.service.inquiry;

import com.w3c.spring.model.vo.inquiry.Board;
import com.w3c.spring.model.vo.inquiry.BoardInsert;
import org.springframework.stereotype.Service;

import java.util.Map;

public interface BoardService {
    public Map<String, Object> getBoardList(int cpage);
    int selectBoardListCount();

    Map<String, Object> getBoardById(int boardId);

    int insertBoard(BoardInsert boardInsert);
    Board selectInquiryDetail(int boardNo);
}
