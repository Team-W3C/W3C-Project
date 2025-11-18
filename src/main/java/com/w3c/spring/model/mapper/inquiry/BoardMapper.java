package com.w3c.spring.model.mapper.inquiry;

import com.w3c.spring.model.vo.inquiry.Answer;
import com.w3c.spring.model.vo.inquiry.Board;
import com.w3c.spring.model.vo.inquiry.BoardInsert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

import java.util.List;
import java.util.Map;

@Mapper
public interface BoardMapper {
    int selectBoardListCount(Map<String, Object> param);
    List<Board> selectBoardList(Map<String, Object> param, RowBounds rowBounds);
    Board getBoardById(int boardId);

    int insertBoard(BoardInsert boardInsert);

    int insertAnswer(Answer answer);
    int updateBoardStatus(@Param("boardId") int boardId,
                          @Param("boardStatus") String boardStatus);
//    Board selectInquiryDetail(int boardNo);
    int selectBoardCountAll();
    int selectBoardCountByStatus(String status);
    int selectBoardCountToday();


    int getBoardMemberId(int boardId);
}
