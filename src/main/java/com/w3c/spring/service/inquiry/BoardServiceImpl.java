package com.w3c.spring.service.inquiry;

import com.w3c.spring.model.mapper.inquiry.BoardMapper;
import com.w3c.spring.model.vo.inquiry.Board;
import com.w3c.spring.model.vo.inquiry.PageInfo;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
@Service
public class BoardServiceImpl implements BoardService{

    private final BoardMapper boardMapper;

    public BoardServiceImpl(BoardMapper boardMapper) {
        this.boardMapper = boardMapper;
    }

    @Override
    public Map<String, Object> getBoardList(int cpage) {
        int listCount = boardMapper.selectBoardListCount();

        PageInfo pi = new PageInfo(cpage, listCount, 5, 10);

        int offset = (cpage - 1) * pi.getBoardLimit();
        RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

        ArrayList<Board> list = (ArrayList)boardMapper.selectBoardList(rowBounds);

        Map<String, Object> map = new HashMap<>();
        map.put("list", list);
        map.put("pi", pi);
        return map;
    }

    @Override
    public int selectBoardListCount() {
        return boardMapper.selectBoardListCount();
    }
}
