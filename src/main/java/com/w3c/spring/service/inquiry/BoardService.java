package com.w3c.spring.service.inquiry;

import org.springframework.stereotype.Service;

import java.util.Map;

public interface BoardService {
    public Map<String, Object> getBoardList(int cpage);
    int selectBoardListCount();
}
