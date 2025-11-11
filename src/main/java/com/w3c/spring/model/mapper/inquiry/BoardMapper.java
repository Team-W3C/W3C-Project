package com.w3c.spring.model.mapper.inquiry;

import com.w3c.spring.model.vo.inquiry.Board;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import java.util.List;

@Mapper
public interface BoardMapper {
    int selectBoardListCount();
    List<Board> selectBoardList(RowBounds rowBounds);
}
