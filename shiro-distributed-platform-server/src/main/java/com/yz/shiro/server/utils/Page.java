package com.yz.shiro.server.utils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

/**
 *
* @ClassName: Page
* @Description: 分页
* @author yangyw(imalex@163.com)
* @date 2015年3月20日 下午2:11:35
*
* @param <T>
 */
public class Page<T> {

    private long pageNo = 1;//页码，默认是第一�?
    private long pageSize = 10;//每页显示的记录数，默认是15
    private long totalRecord;//总记录数
    private long totalPage;//总页�?
    private List<T> results;//对应的当前页记录
    private Map<String, Object> params = new HashMap<String, Object>();//其他的参数我们把它分装成�?个Map对象
    private HttpServletRequest request;//
    public long getPageNo() {
       return pageNo;
    }

    public void setPageNo(long pageNo) {
       this.pageNo = pageNo;
    }

    public long getPageSize() {
       return pageSize;
    }

    public void setPageSize(long pageSize) {
       this.pageSize = pageSize;
    }

    public long getTotalRecord() {
       return totalRecord;
    }

    public void setTotalRecord(long totalRecord) {
       this.totalRecord = totalRecord;
       //在设置�?�页数的时�?�计算出对应的�?�页数，在下面的三目运算中加法拥有更高的优先级，�?以最后可以不加括号�??
       long totalPage = totalRecord%pageSize==0 ? totalRecord/pageSize : totalRecord/pageSize + 1;
       this.setTotalPage(totalPage);
    }

    public long getTotalPage() {
       return totalPage;
    }

    public void setTotalPage(long totalPage) {
       this.totalPage = totalPage;
    }

    public List<T> getResults() {
       return results;
    }

    public void setResults(List<T> results) {
       this.results = results;
    }

    public Map<String, Object> getParams() {
       return params;
    }

    public void setParams(Map<String, Object> params) {
       this.params = params;
    }

    public HttpServletRequest getRequest() {
		return request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	@Override
    public String toString() {
       StringBuilder builder = new StringBuilder();
       builder.append("Page [pageNo=").append(pageNo).append(", pageSize=")
              .append(pageSize).append(", results=").append(results).append(
                     ", totalPage=").append(totalPage).append(
                     ", totalRecord=").append(totalRecord).append("]");
       return builder.toString();
    }

}
