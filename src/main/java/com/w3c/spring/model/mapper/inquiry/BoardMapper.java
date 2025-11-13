package com.w3c.spring.model.mapper.inquiry;

import com.w3c.spring.model.vo.inquiry.Answer;
import com.w3c.spring.model.vo.inquiry.Board;
import com.w3c.spring.model.vo.inquiry.BoardInsert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

import java.util.List;

@Mapper
public interface BoardMapper {
    int selectBoardListCount();
    List<Board> selectBoardList(RowBounds rowBounds);
    Board getBoardById(int boardId);

    int insertBoard(BoardInsert boardInsert);

    int insertAnswer(Answer answer);
    int updateBoardStatus(@Param("boardId") int boardId,
                          @Param("boardStatus") String boardStatus);
//    Board selectInquiryDetail(int boardNo);
}
