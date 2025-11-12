package com.w3c.spring.service.inquiry;

import com.w3c.spring.model.mapper.inquiry.BoardMapper;
import com.w3c.spring.model.vo.inquiry.Board;
import com.w3c.spring.model.vo.inquiry.BoardInsert;
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

        for (Board b : list) {
            enrichBoard(b);

        }
        Map<String, Object> map = new HashMap<>();
        map.put("list", list);
        map.put("pi", pi);
        return map;
    }


    @Override
    public int selectBoardListCount() {
        return boardMapper.selectBoardListCount();
    }

    @Override
    public Map<String, Object> getBoardById(int boardId) {
        Map<String, Object> map = new HashMap<>();

        Board board = boardMapper.getBoardById(boardId);

        enrichBoard(board);

        

        map.put("boardDetail", board);
        return map;
    }

    @Override
    public int insertBoard(BoardInsert boardInsert) {
        int result = boardMapper.insertBoard(boardInsert);



        return result;
    }

    private void enrichBoard(Board b) {
        switch (b.getBoardType()) {
            case 1 : b.setBoardTypeName("결제"); break;
            case 2 : b.setBoardTypeName("진료"); break;
            case 3 : b.setBoardTypeName("기타");break;
            case 4 : b.setBoardTypeName("시스템"); break;
            case 5 : b.setBoardTypeName("예약");break;
            default : b.setBoardTypeName("알수없음");break;
        }
        b.setBoardSecretTypeName("T".equals(b.getBoardSecretType()) ? "비밀" : "공개");
    }
}
