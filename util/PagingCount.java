package util;

public class PagingCount {
	int links = 10;
	int limit = 10;
	int totalpage = 0;
	
	public PagingCount() { }
	public PagingCount(int numrows) {
		this.totalpage = ((numrows-1)/limit)+1;
	}
	//links개수 변경 시 
	public PagingCount(int numrows, int links, int limit) {
		this.links = links;
		this.limit = limit;
		this.totalpage = ((numrows-1)/limit)+1;
	}
	//페이지 번호 들어갔을 때  행번호 구하기
	public int countOffset(int page) {
		int offset = (page-1)*this.limit;
		return offset;
	}
	public String showPaging(int pagelink, String pagename) {
		String str = "<table><tr><td>";
		int bpage, boffset,cpage,coffset,vpage,noffset,loffset = 0;
		//first page
		if(pagelink != 1) {
			str += "[<a href="+pagename+"?pagelink=1&offset=0>"
					+ "<font>처음</font></a>]";
		}else {
			str += "[<font>처음</font></a>]";
		}
		//back 10page
		bpage = pagelink-10;
		boffset = countOffset(bpage);
		if(pagelink > links) {
			str += "[<a href="+pagename+"?pagelink="+bpage+"&offset="+boffset+">"
					+ "<font>이전 10</font></a>]";
		}else {
			str += "[<font>이전 10</font></a>]";
		}
		//link page
		vpage = pagelink; //현재페이지를 다른변수로 사용
		pagelink = ((pagelink-1)/links)*links+1; //시작페이지 구하기
		for(cpage=pagelink; cpage<pagelink+links; cpage++) {
			if(cpage>totalpage) break;
			coffset = countOffset(cpage);
			if(cpage!=vpage) {
				str += "[<a href="+pagename+"?pagelink="+cpage+"&offset="+coffset+">"
						+ "<font>"+cpage+"</font></a>]";
			}else {
				str += "[<font>"+cpage+"</font></a>]";
			}
		}
		//next 10page
		//for문을 빠져나왔을 때 cpage는 1만큼 증가되어있기 때문에 바로 사용
		 noffset = countOffset(cpage);
		 if((totalpage-pagelink) >= links) {
			 str += "[<a href="+pagename+"?pagelink="+cpage+"&offset="+noffset+">"
					 + "<font>다음 10</font></a>]";
		 }else {
			 str += "[<font>다음 10</font></a>]";
		 }
		 //last page
		 loffset = countOffset(totalpage);
		 if(vpage != totalpage) {
			 str += "[<a href="+pagename+"?pagelink="+totalpage+"&offset="+loffset+">"
					+ "<font>마지막</font></a>]";
		 }else {
			str += "[<font>마지막</font></a>]";
		 }
		str += "</td></tr></table>";
		return str;
	}
	
	//
	public String showPaging(int pagelink, String pagename, String find, String search) {
		String str = "<table><tr><td>";
		int bpage, boffset,cpage,coffset,vpage,noffset,loffset = 0;
		//first page
		if(pagelink != 1) {
			str += "[<a href="+pagename+"?pagelink=1&offset=0>"
					+ "<font>처음</font></a>]";
		}else {
			str += "[<font>처음</font></a>]";
		}
		//back 10page
		bpage = pagelink-10;
		boffset = countOffset(bpage);
		if(pagelink > links) {
			str += "[<a href="+pagename+"?pagelink="+bpage+"&offset="+boffset+"&find="+find+"&search="+search+">"
					+ "<font>이전 10</font></a>]";
		}else {
			str += "[<font>이전 10</font></a>]";
		}
		//link page
		vpage = pagelink; //현재페이지를 다른변수로 사용
		pagelink = ((pagelink-1)/links)*links+1; //시작페이지 구하기
		for(cpage=pagelink; cpage<pagelink+links; cpage++) {
			if(cpage>totalpage) break;
			coffset = countOffset(cpage);
			if(cpage!=vpage) {
				str += "[<a href="+pagename+"?pagelink="+cpage+"&offset="+coffset+"&find="+find+"&search="+search+">"
						+ "<font>"+cpage+"</font></a>]";
			}else {
				str += "[<font>"+cpage+"</font></a>]";
			}
		}
		//next 10page
		//for문을 빠져나왔을 때 cpage는 1만큼 증가되어있기 때문에 바로 사용
		 noffset = countOffset(cpage);
		 if((totalpage-pagelink) >= links) {
			 str += "[<a href="+pagename+"?pagelink="+cpage+"&offset="+noffset+"&find="+find+"&search="+search+">"
					 + "<font>다음 10</font></a>]";
		 }else {
			 str += "[<font>다음 10</font></a>]";
		 }
		 //last page
		 loffset = countOffset(totalpage);
		 if(vpage != totalpage) {
			 str += "[<a href="+pagename+"?pagelink="+totalpage+"&offset="+loffset+"&find="+find+"&search="+search+">"
					+ "<font>마지막</font></a>]";
		 }else {
			str += "[<font>마지막</font></a>]";
		 }
		str += "</td></tr></table>";
		return str;
	}
}
