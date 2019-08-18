package com.music.dao;

import com.music.bean.Search;
import java.math.BigDecimal;
import java.util.List;

public interface SearchDao {
	//插入搜索信息
    int insert(Search record);
    //获取全部的搜索信息
    List<Search> getAllSearch();
    //修改搜索信息(搜索的字段已经存在，修改次数)
    int updateSearch(Search search);
    
    //模糊查询数据库是否有过相关查询
    Search getOneSearchByLike(Search search);
    //模糊查询有结果则修改count加一
    Integer updateSearchOfCount(Search search);
    //模糊查询不能查到数据则新增
    Integer addNewSearch(Search search);
    //获取热搜榜单
    List<Search> getHotSearch();
    
    
}