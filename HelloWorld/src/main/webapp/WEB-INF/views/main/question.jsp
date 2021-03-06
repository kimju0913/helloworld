<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>

<head>
<style type="text/css">
li {
	list-style: none;
}

ul {
	list-style-type: none;
}

li {
	display: inline-block;
}
</style>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<meta charset="UTF-8">
<title>Helloworld::고객센터</title>


</head>
<%@ include file="/resources/import/qnaboard.jspf"%>
<body>




	<div id="titlebar">
		<div id="div_q_bno">번호</div>
		<c:if test="${q_menu == null || q_menu == '' }">
		<div id="div_q_menu">
			<select style="width: 70px; height: 30px;" id="click_menu"
				name="q_menu" size="1">
				<option class="menu_select" value="">분류</option>
				<option class="menu_select" value="ALL">전체</option>
				<option class="menu_select" value="욕설">욕설</option>
				<option class="menu_select" value="음란물">음란물</option>
				<option class="menu_select" value="기타">기타</option>
			</select>
		</div>
		</c:if>
		<c:if test="${q_menu != null }">
		<div id="div_q_menu">
			<select style="width: 70px; height: 30px;" id="click_menu"
				name="q_menu" size="1">
				<option class="menu_select" value="${q_menu}">${q_menu}</option>
				<option class="menu_select" value="ALL">전체</option>
				<option class="menu_select" value="욕설">욕설</option>
				<option class="menu_select" value="음란물">음란물</option>
				<option class="menu_select" value="기타">기타</option>
			</select>
		</div>
		</c:if>
		
		
		
		
		
		
		<div id="div_q_answer">답변 상태</div>
		<div id="div_q_content">제목</div>
		<div id="div_q_name">문의자</div>
		<div id="div_q_date">등록일</div>
	</div>


	<div>
		<hr>


		<!--                      문의사항 전체 -->

		<!-- 내용판  -->
		<div id="question">
			<c:forEach var="vo" items="${qlist}">
				<fmt:formatDate value="${vo.q_date }" pattern="yyyy-MM-dd"
					var="q_date" />
				<div class="divc"
					onclick="opendiv('${vo.q_bno}','${vo.userid}' ,'${vo.q_secret  }')">
					<input hidden="hidden" id="useridcontent" value="${vo.userid }">
					<input class="q_secret" type="hidden" value="${vo.q_secret }">
					<div id="div_q_bno">${vo.q_bno }</div>
					<div id="div_q_menu">${vo.q_menu}</div>

					<c:if test="${vo.q_answer == null}">
						<div id="div_q_answer">
							<a style="color: red">답변 대기</a>
						</div>
					</c:if>
					<c:if test="${vo.q_answer != null}">
						<div id="div_q_answer">
							<a style="color: green;">답변 완료</a>
						</div>
					</c:if>
					<c:if test="${vo.q_secret == 'Y'}">
						<div id="div_q_content">
							<a class="viewhidden">${vo.q_title}</a><img
								src="${pageContext.request.contextPath}/resources/images/lockIcon.png">
						</div>
					</c:if>
					<c:if test="${vo.q_secret != 'Y'}">
						<div id="div_q_content">
							<a class="viewhidden">${vo.q_title}</a>
						</div>


					</c:if>
					<div id="div_q_name">${vo.user_name}</div>
					<div id="div_q_date">${q_date}</div>
					<br>

				</div>



				<!-- display:n -->
				<div id="check_on_off${vo.q_bno }"
					style="margin-left: 200px; display: none;">
					<br>
					<div>
						<table>
							<tr>
								<th><img style="padding-top: 6px"
									src="${pageContext.request.contextPath}/resources/images/QNAQ.PNG"></th>

								<td><textarea id="q_content" readonly>${vo.q_content }</textarea></td>
							</tr>

						</table>

					</div>
					<br>
					<c:if test="${vo.q_answer != null }">
						<div>
							<table>
								<tr>
									<th><img style="padding-top: 6px"
										src="${pageContext.request.contextPath}/resources/images/QNAA.PNG"></th>

									<td><textarea id="q_content" readonly>${vo.q_answer }</textarea></td>
								</tr>

							</table>


						</div>
					</c:if>

				</div>



				<hr>
			</c:forEach>
		</div>

		<div id="paging">
			<ul class="pager">

				<c:if test="${pageMaker.hasPrev }">
					<li><a href="${pageMaker.startPageNo - 1 }">◀</a></li>
				</c:if>

				<c:forEach begin="${pageMaker.startPageNo }"
					end="${pageMaker.endPageNo }" var="num">
					<li><a href="${num }"> ${num } | </a></li>
				</c:forEach>
				<c:if test="${pageMaker.hasNext }">
					<li><a href="${pageMaker.endPageNo + 1 }">▶</a></li>
				</c:if>
			</ul>
		</div>
		<div>
			<form id="pagingForm" style="display: none;">
				<input type="text" name="page" value="${pageMaker.criteria.page }">
				
				<input type="text" name="q_menu" value="${q_menu }">
			</form>
		</div>




		<!-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ  나의 문의사항 -->





		<script type="text/javascript">
		
		

		 $(document).ready(function() {
				
				  
				  $('.pager li a').click(function(){
			            console.log("클릭");
			            var q_menu = $('#click_menu').val();
			            console.log(q_menu);
			            
			              event.preventDefault();
			              var targetPage = $(this).attr('href');
			              console.log(targetPage);
			              var frm = $('#pagingForm');
			              frm.find('[name = "page"]').val(targetPage);
			              frm.find('[name = "q_menu"]').val(q_menu);
			              frm.attr('method', 'get');
			              frm.attr('action','question');
			              frm.submit();
			           }); // end pager clicked  
			  });
			function opendiv(bno, userid, secret) {
				//check_on_off
				console.log("bno:::" + bno);
				console.log("userid:::" + userid);
				console.log("secret:::" + secret);

				var loginId = '${loginId}';

				var on_off = '#check_on_off' + bno;
				var status = $(on_off).css("display");

				console.log("on_off" + on_off);

				if (secret == 'Y') {

					if (userid == loginId) {
						if (status == "none") {
							$(on_off).css("display", "");
						} else {
							$(on_off).css("display", "none");
						}
					} else {

						alert('비밀글은 작성자만 조회할 수 있습니다.')
					}

				} else {

					if (status == "none") {
						$(on_off).css("display", "block");
					} else {
						$(on_off).css("display", "none");
					}
				}
			}

			$('#add_qna').click(function() {// 마이페이지 버튼 클릭 

				location = '/helloworld/main/qna';

			});

			$("#click_menu").change(function() {
				var menu = $(this).val();
				event.preventDefault();
				console.log(menu);

				location = '/helloworld/main/question?q_menu=' + menu;

				//var status = $("#an_list").css("display");

			});
		</script>
</body>
</html>