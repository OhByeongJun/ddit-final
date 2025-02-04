<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="https://cdn.ckeditor.com/ckeditor5/41.4.2/super-build/ckeditor.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sortablejs@1.14.0/Sortable.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/perfect-scrollbar/1.5.3/css/perfect-scrollbar.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/perfect-scrollbar/1.5.3/perfect-scrollbar.min.js"></script>

<div class="app-email card" id="approval">
    <div class="row g-0">
    	<!-- 문서함 리스트 -->
        <%@ include file="subMenu.jsp" %>
        <!--// 문서함 리스트 -->
        
		<!-- 컨텐츠 영역 -->
        <div class="col flex-grow-0 approval-list scrollable-content" id="approval-list">
        <div class="detail">
	        <div class="content-header pb-2">
	        <div>
	        	<div id="atNm"></div>
	        	<div class="btn-compost-wrapper">
					<button class="btn btn-sm btn-outline-primary btn-compose " 
						data-bs-toggle="modal" data-bs-target="#aproveInfoModal" 
						id="newApproval">결재 정보
					</button>
					</div>
				</div> 
	        	<div id="paymentBox">
		        	<div id="applyBox">
					    <table class="apprTable">
							<tr>
								<th rowspan="2">신청</th>
							</tr>
							<tr>
								<td>
									<div class="bb-1">${loginVO.jbgdNm}</div>
					                <div class="bb-1 approveLine">
					                	<div>${loginVO.empNm}</div>  
					                </div>
									<div><br></div>
								</td>
							</tr>
						</table>
					</div>
					<div id="approveBox">
					</div>
					<div id="ccBox">
					</div>
	        	</div>
			</div> 
			<div class="content-body">
				<table class="apprEditor">
					<tr>
						<th>제목</th>
						<td><input type="text" id="title" class="p-1" style="width: 100%" /></td>
					</tr>
					<tr>
						<td colspan="2"><div id="editor"></div></td>
					</tr>
				</table>
				<form action="" enctype="multipart/form-data"></form>
				<div class="fileBox my-4">
					<span class="dd_text">파일첨부</span>
					<div id="dropZone" class="dd_attach dd_zone">
						<div class="area_txt">
							<span class="ic_attach ic_upload"></span> 
							<span class="msg">이곳에 파일을 드래그 하세요. 또는 
								<span class="btn_file">
									<span class="txt">파일선택</span>
									<input type="file" title="파일선택" multiple id="atchFile">
								</span>
							</span>
						</div>
						<div class="area_img" id="areaImg">
	            
						</div>
						<div class="area_file" id="areaFile">
	
						</div>
					</div>
				</div>
				<div class="fileBox my-4">
					<span class="dd_text">관련문서</span>
					<div class="dd_zone">
						<button type="button" class="btn btn-xs btn-outline-dark waves-effect"
							data-bs-toggle="modal" data-bs-target="#searchDocumentModal" >문서 검색</button>
						<div class="area_file" id="areaDoc">
						
						</div>
					</div>
				</div>
			</div>
			<hr>
			<div class="content-footer">
				<label class="switch switch-danger">
					<input type="checkbox" class="switch-input" id="aprvrEmgyn" />
					<span class="switch-toggle-slider">
						<span class="switch-on"></span>
						<span class="switch-off"></span>
					</span>
					<span class="switch-label">긴급</span>
				</label>
				<div style="text-align: right">
					<button type="button" class="btn btn-primary" id="approveSubmit">결재상신</button>
					<button type="button" class="btn btn-success" id="approveTempSave">임시저장</button>
					<button type="button" class="btn btn-secondary" id="approveCancel">취소</button>
				</div>
        	</div>
        </div>
        </div>
        <!--// 컨텐츠 영역 -->
    </div>
</div>


<script>
const urlParams = new URL(location.href).searchParams;
const atCd= urlParams.get('atCd');
const empId = ${loginVO.empId};
const header = "${_csrf.headerName}";
const token ="${_csrf.token}";

/******* scroll 영역 *******/

new PerfectScrollbar(document.getElementById('documentBox'), {
  wheelPropagation: false
});

new PerfectScrollbar(document.getElementById('approval-list'), {
  wheelPropagation: false
});

new PerfectScrollbar(document.getElementById('searchDocumentModalBody'), {
  wheelPropagation: false
});

/******* // scroll 영역 *******/

/******* ckEditor 영역 *******/
 
CKEDITOR.ClassicEditor.create(document.getElementById("editor"), {
    // https://ckeditor.com/docs/ckeditor5/latest/features/toolbar/toolbar.html#extended-toolbar-configuration-format
    toolbar: {
      items: [
        "exportPDF",
        "|",
        "findAndReplace",
        "selectAll",
        "|",
        "heading",
        "|",
        "bold",
        "italic",
        "strikethrough",
        "underline",
        "code",
        "subscript",
        "superscript",
        "removeFormat",
        "|",
        "bulletedList",
        "numberedList",
        "todoList",
        "|",
        "outdent",
        "indent",
        "|",
        "undo",
        "redo",
        "-",
        "fontSize",
        "fontFamily",
        "fontColor",
        "fontBackgroundColor",
        "highlight",
        "|",
        "alignment",
        "|",
        "link",
        "uploadImage",
        "blockQuote",
        "insertTable",
        "mediaEmbed",
        "codeBlock",
        "|",
        "specialCharacters",
        "horizontalLine",
        "|",
        "sourceEditing",
      ],
      shouldNotGroupWhenFull: true,
    },
    // https://ckeditor.com/docs/ckeditor5/latest/features/headings.html#configuration
    heading: {
      options: [
        {
          model: "paragraph",
          title: "Paragraph",
          class: "ck-heading_paragraph",
        },
        {
          model: "heading1",
          view: "h1",
          title: "Heading 1",
          class: "ck-heading_heading1",
        },
        {
          model: "heading2",
          view: "h2",
          title: "Heading 2",
          class: "ck-heading_heading2",
        },
      ],
    },
    // https://ckeditor.com/docs/ckeditor5/latest/features/editor-placeholder.html#using-the-editor-configuration
    // https://ckeditor.com/docs/ckeditor5/latest/features/font.html#configuring-the-font-family-feature
    fontFamily: {
      options: ["default", "Arial, Helvetica, sans-serif"],
      supportAllValues: true,
    },
    // https://ckeditor.com/docs/ckeditor5/latest/features/font.html#configuring-the-font-size-feature
    fontSize: {
      options: [10, 12, 14, "default", 18, 20, 22],
      supportAllValues: true,
    },
    // Be careful with the setting below. It instructs CKEditor to accept ALL HTML markup.
    // https://ckeditor.com/docs/ckeditor5/latest/features/general-html-support.html#enabling-all-html-features
    htmlSupport: {
      allow: [
        {
          name: /.*/,
          attributes: true,
          classes: true,
          styles: true,
        },
      ],
    },
    // https://ckeditor.com/docs/ckeditor5/latest/features/link.html#custom-link-attributes-decorators
    link: {
      decorators: {
        addTargetToExternalLinks: true,
        //   defaultProtocol: "https://",
        toggleDownloadable: {
          mode: "manual",
          label: "Downloadable",
          attributes: {
            download: "file",
          },
        },
      },
    },
    // The "superbuild" contains more premium features that require additional configuration, disable them below.
    // Do not turn them on unless you read the documentation and know how to configure them and setup the editor.
    removePlugins: [
      // These two are commercial, but you can try them out without registering to a trial.
      // 'ExportPdf',
      // 'ExportWord',
      "AIAssistant",
      "CKBox",
      "CKFinder",
      "EasyImage",
      // This sample uses the Base64UploadAdapter to handle image uploads as it requires no configuration.
      // https://ckeditor.com/docs/ckeditor5/latest/features/images/image-upload/base64-upload-adapter.html
      // Storing images as Base64 is usually a very bad idea.
      // Replace it on production website with other solutions:
      // https://ckeditor.com/docs/ckeditor5/latest/features/images/image-upload/image-upload.html
      // 'Base64UploadAdapter',
      "MultiLevelList",
      "RealTimeCollaborativeComments",
      "RealTimeCollaborativeTrackChanges",
      "RealTimeCollaborativeRevisionHistory",
      "PresenceList",
      "Comments",
      "TrackChanges",
      "TrackChangesData",
      "RevisionHistory",
      "Pagination",
      "WProofreader",
      // Careful, with the Mathtype plugin CKEditor will not load when loading this sample
      // from a local file system (file://) - load this site via HTTP server if you enable MathType.
      "MathType",
      // The following features are part of the Productivity Pack and require additional license.
      "SlashCommand",
      "Template",
      "DocumentOutline",
      "FormatPainter",
      "TableOfContents",
      "PasteFromOfficeEnhanced",
      "CaseChange",
    ],
  })
    .then((editor) => {
      jwEditor = editor; // Save for later use.
    })
    .catch((error) => {
      console.error(error);
    });

$(function(){
	fetch("/approval/"+atCd)
		.then((resp)=>{
			resp.json().then((data)=>{
				console.log(data);
				jwEditor.setData(data.atCn);
				$('#atNm').html(`<h3>\${data.atNm}</h3>`);
				
			})
		})
});


/******* // ckEditor 끝 *******/

let id = "";
let str = "";
let tabId = "approve";
let alIdList = [];
let ccIdList = [];  
let attachFileList = [];

const atchFile = document.querySelector('#atchFile');
const dropZone = document.querySelector('#dropZone');
const areaImg = document.querySelector('#areaImg');
const areaFile = document.querySelector('#areaFile');
const approveBox = document.querySelector('#approveBox');
const ccBox = document.querySelector('#ccBox');

//결재정보모달 - 결재선/참조자 탭
$('.nav-link-info').on('click', function(){
    tabId = $(this).data('tab');
    console.log(tabId);
});

/******* 파일 드래그앤드랍 *******/

$('#dropZone').on('dragover', function(){
  event.preventDefault();
  event.stopPropagation();
})

// 파일 드랍 이벤트 (<div id="dropZone")
$('#dropZone').on('drop', function(){
  event.preventDefault();
  event.stopPropagation();

  let userSelFiles = event.dataTransfer.files;
  for(let i=0; i<userSelFiles.length; i++){
//     console.log(userSelFiles[i].name);
    f_readOneFile(i, userSelFiles[i]);
  }

});

// 파일첨부 이벤트 (<input type="file")
atchFile.addEventListener('change', function() {
  let userSelFiles = event.target.files;
  for(let i = 0; i < userSelFiles.length; i++) {
    f_readOneFile(i, userSelFiles[i]);
  }
});

// 이미지파일 화면미리보기
function addImageFile(fileReader, pFile) {
    let str = `
        <span class="item_image ms-3">
            <span class="imgPreview">
                <img src="\${fileReader.result}" alt="\${pFile.name}">
            </span>
            <span class="name">\${pFile.name}</span>
            <span class="delete-icon"><i class="ti ti-x"></i></span>
        </span>`;
        
    	areaImg.innerHTML += str;
}

// 일반파일 화면미리보기
function addGeneralFile(pFile) {
    let str = `
        <span class="item_file ms-3">
            <span class="name">\${pFile.name}</span>
            <span class="delete-icon"><i class="ti ti-x"></i></span>
        </span>`;
        
    	areaFile.innerHTML += str;
}

// 파일을 읽어서 첨부파일 리스트에 추가하고 화면미리보기
function f_readOneFile(pIdx, pFile){
	// 첨부파일 리스트에 넣기
	attachFileList.push(pFile);
	let fileType = pFile.type.split("/")[0];
	  
	let fileReader = new FileReader();
	fileReader.readAsDataURL(pFile);
	fileReader.onload = function(){
	
	// 파일타입에 따라 화면에 미리보기추가
    if(fileType == 'image'){
    	addImageFile(fileReader, pFile);
    }else{
    	addGeneralFile(pFile);
    }
  }
}

// 서버로 보낼 파일 고르는 함수
function f_ckFileList() {
	
    // 보낼 파일 리스트
    let sendFileList = document.querySelectorAll(".name");
//     console.log("sendFileList" ,sendFileList[0].innerText);

    //파일 고르기
    let selFiles = attachFileList.filter(aFile => {
        for (let i = 0; i < sendFileList.length; i++) {
            if (aFile.name == sendFileList[i].innerText) {
                return true;
            }
        }
        return false;
    })
    return selFiles;
}

// 파일삭제
$(document).on('click', '.delete-icon', function(){
  $(this).parent().remove();
})


/******* // 파일 드래그앤드랍  끝 *******/



/******* jsTree *******/

// 검색
$("#schEmpName").on("input", function(){
    $('#jstree').jstree(true).search($("#schEmpName").val());
    if($("#schEmpName").val() == ""){
    	str = "";
        $("#detail").html(str);
    }
});


$.jstree.defaults.core.themes.variant = "large";

// 데이터를 Ajax로 불러온 후 정렬하여 JSTree에 설정
$.ajax({
    url: "/orgchart/select", // 서버에서 데이터를 받아올 URL
    type: "GET",
    success: function(data) {
        // 데이터를 PARENT에 따라 그룹화
        let groupedData = data.reduce((acc, item) => {
            if (!acc[item.parent]) {
                acc[item.parent] = [];
            }
            acc[item.parent].push(item);
            return acc;
        }, {});

        // 자식 노드가 없는 D001의 자식 노드를 먼저 추가
        let treeData = [];
        let addedNodes = new Set();

        // D001의 자식 중 자식이 없는 노드 찾기
        let d001Children = groupedData['D001'] || [];
        let noChildD001Children = d001Children.filter(item => !(groupedData[item.id] && groupedData[item.id].length));

        // 자식이 없는 D001의 자식 노드를 먼저 추가
        noChildD001Children.forEach(item => {
            if (!addedNodes.has(item.id)) {
                treeData.push(item);
                addedNodes.add(item.id);
            }
        });

        // 일반적인 노드 추가 함수
        function addNodeAndChildren(nodeId) {
            if (groupedData[nodeId]) {
                groupedData[nodeId].forEach(item => {
                    if (!addedNodes.has(item.id)) {
                        treeData.push(item);
                        addedNodes.add(item.id);
                        addNodeAndChildren(item.id);
                    }
                });
            }
        }

        // D001의 나머지 자식 노드 추가
        d001Children.forEach(item => {
            if (!noChildD001Children.includes(item)) {
                if (!addedNodes.has(item.id)) {
                    treeData.push(item);
                    addedNodes.add(item.id);
                    addNodeAndChildren(item.id);
                }
            }
        });

        // 나머지 노드들 추가
        for (let parent in groupedData) {
            if (parent !== 'D001') {
                groupedData[parent].forEach(item => {
                    if (!addedNodes.has(item.id)) {
                        treeData.push(item);
                        addedNodes.add(item.id);
                        addNodeAndChildren(item.id);
                    }
                });
            }
        }

        $("#jstree").jstree({
            "plugins": ["search"],
            'core': {
                'data': treeData,
                "check_callback": true,
            }
        });
    }
});

/******* // jsTree 끝 *******/

// 결재선테이블 비동기 생성
function addApprTable(list, box){
	let str = `
    	<table class="apprTable ms-sm-2">
			<tr>`;
	
	// 참조자일 때
	if(box == ccBox){
		str += `<th rowspan="2">참조</th>`;
	// 결재자일 때			
	}else{
		str += `<th rowspan="2">승인</th>`;
	}
	
	str += `
			</tr>
			<tr>`;
			
	list.forEach(function(apList, idx){
		str += `
			<td>
				<div class="bb-1">\${apList.job}</div>
				<div class="bb-1 approveLine">
					<div>\${apList.empNm}</div>  
				</div>
				<div><br></div>
			</td>`;
	});
	
	str += `
			</tr>
		</table>`;

	// 결재자/참조자가 있으면
	if(list.length > 0){
	    box.innerHTML = str;
	// 없으면
    }else{
	    box.innerHTML = '';
    }
}

// jsTree 이벤트
$('#jstree').on("changed.jstree", function (e, data) {
    console.log(data.selected);
});

// Node 선택시 결재자/참조자탭인지에 따라 결재정보 모달에 추가
$('#jstree').on("select_node.jstree", function (e, data) {
//     console.log("select했을땡", data.node);
    id = data.node.id;
    
    // 부서이름 가져오기
    parent = $('#jstree').jstree(true).get_node(data.node.parent).text;
    // 직원이름 가져오기
    name = data.node.text;
    
//     console.log("parentNm : " + parent );
//     console.log("tabId : " + tabId);

    let str = "";
    
    // 하위노드가 없을 때(부서가 선택되지 않게 하기 위함)
    if(data.node.children.length == 0 ){
		str = `
			<li value="\${id}" class="drag-handle cursor-move list-group-item lh-1 d-flex justify-content-between align-items-center" >
				\${parent} \${name}
				<i class="ti ti-trash align-text-bottom me-2 item"></i>
			</li>`;
    }
    
    // 결재선
    if(tabId == 'approve'){
		
    	// 결재자리스트 영역에 추가
	    $('#approveList').append(str);
    	
    	// 드래그 가능하도록 sortable 라이브러리 사용
	    approveList = document.getElementById('approveList');
	    Sortable.create(approveList, {
	        animation: 150,
	        group: 'handleList',
	        handle: '.drag-handle'
	      });
    }
    
    // 참조자
    if(tabId == 'corbon'){
    	
    	// 참조자리스트 영역에 추가
	    $('#corbonList').append(str);
    	
	 	// 드래그 가능하도록 sortable 라이브러리 사용
	    corbonList = document.getElementById('corbonList');
	    Sortable.create(corbonList, {
	        animation: 150,
	        group: 'handleList',
	        handle: '.drag-handle'
	      });
    }
    
});

// 삭제버튼 클릭
$('#approveList').on('click', '.item', function() {
   	$(this).parent().remove();
});

// 삭제버튼 클릭
$('#corbonList').on('click', '.item', function() {
   	$(this).parent().remove();
});


// 결재정보 모달의 저장버튼 클릭할 때
$('#modalSave').on('click', function(){
	
	alIdList = [];
	ccIdList = [];  
	
	approveLineList = [];
	corbonCopyList = [];
	
	// 결재선
    $('#approveList').children().each(function() {
    	alIdList.push($(this).attr('value'));
    	
        let dataId = {
                "id" : $(this).attr('value')	
        };
    	
    	 $.ajax({
             url : "/orgchart/detail",
             contentType: "application/json;charset=utf-8",
             data: JSON.stringify(dataId),
             type: "post",
             async: false,
             dataType: "json",
             beforeSend: function(xhr){
                 xhr.setRequestHeader(header, token);
             },
             success: function(result){
                 console.log("result : ", result);
                 approveLineList.push({
                	 empNm : result.empNm,
                	 job : result.jobGradeVO.jbgdNm
                 })
             }
         });
    });
    
	// 참조자
    $('#corbonList').children().each(function() {
    	ccIdList.push($(this).attr('value'));
    	
    	let dataId = {
               "id" : $(this).attr('value')	
        };
    	
    	 $.ajax({
             url : "/orgchart/detail",
             contentType: "application/json;charset=utf-8",
             data: JSON.stringify(dataId),
             type: "post",
             async: false,
             dataType: "json",
             beforeSend: function(xhr){
                 xhr.setRequestHeader(header, token);
             },
             success: function(result){
                 console.log("result : ", result);
                 corbonCopyList.push({
                	 empNm : result.empNm,
                	 job : result.jobGradeVO.jbgdNm
                 })
             }
         });
    });
    
    
    Swal.fire({
        position: 'center',
        icon: 'success',
        title: '결재정보가 저장되었습니다',
        showConfirmButton: false,
        timer: 1000,
        customClass: {
          confirmButton: 'btn btn-primary waves-effect waves-light'
        },
        buttonsStyling: false
      });
    
    // 결재테이블 추가
    addApprTable(approveLineList, approveBox);
    addApprTable(corbonCopyList, ccBox);
    
})

// 결재상신버튼 클릭할 때
$('#approveSubmit').on('click', function(){
	
	let content = jwEditor.getData();
	let title = $('#title').val();
	
	let formData = new FormData();
	
	// 제목은 필수
	if(title == ""){
		$('#title').focus();
		return;
	}
	
	// 결재자는 한 명 이상 필수
	if( !alIdList.length > 0){
		Swal.fire({
		    title: '결재자 미등록!',
		    text: ' 결재자를 등록해주세요',
		    type: 'warning',
		    customClass: {
		      confirmButton: 'btn btn-primary'
		    },
		    buttonsStyling: false
		  })
		  return;
	}
	
	// 화면에 남은 파일 리스트
	let fileList = f_ckFileList();
// 	console.log("fileList", fileList);
	fileList.forEach(file => {
		
		// 폼데이터에 파일 추가
    	formData.append("file", file);
  })
	
	// 참조자   
	let corbonCopyList = [];
    for (let i = 0; i < ccIdList.length; i++) {
    	corbonCopyList.push({accCc: ccIdList[i]});
    }
    
    // 결재자
    let approvalLineList = [];
    
    // 결재상신자
    approvalLineList.push({
		alAutzrNm: empId,
		alSeq: 1,
		alStts: "A01"    	
    })
    // 그 외 결재자
    for(let i=0; i<alIdList.length; i++){
    	approvalLineList.push({
    		alAutzrNm: alIdList[i],
    		alSeq: i + 2,
    		// 첫 번째 결재자는 결재대기, 그 외는 결재예정상태
    		alStts: i === 0 ? "A04" : "A05"
    	})
    	
    	// 알람 웹소켓 시작
		let approvalAL = "approvalAL";
        
       	let socketMsg	=	{
       			"title":approvalAL,
       			"senderId":empId,
       			"receiverId":alIdList[i],
       			"apprTitle":title,
       			"alStts":i === 0 ? "A04" : "A05"
       	}
       	
       	socket.send(JSON.stringify(socketMsg));
     	// 알람 웹소켓 끝
    }
    
    // 긴급여부
    let aprvrEmgyn = document.querySelector('#aprvrEmgyn').checked;
    
    // 관련문서 리스트
    let checkRelList = document.querySelectorAll('.docNo');
    let relatedApprovalList = [];
    for(let i=0; i<checkRelList.length; i++){
    	relatedApprovalList.push({
    		raNo: checkRelList[i].getAttribute('data-aval')
    	})
    }
    
//     console.log(approvalLineList);
//     console.log(corbonCopyList);
    console.log(relatedApprovalList);
//     console.log(aprvrEmgyn);
//     console.log(aprvrEmgyn === true ? "Y" : "N");
    
    // VO형식으로 데이터변환
    let approvalVO = {
    	"aprvrDocTtl":title,
    	"empId": empId,
    	"aprvrDocCn":content,
    	"atCd":atCd,
    	"aprvrEmgyn": aprvrEmgyn === true ? "Y" : "N",
    	"approvalLineList":approvalLineList,
    	"corbonCopyList":corbonCopyList,
    	"aprvrSttsCd":"A07",
    	"relatedApprovalList":relatedApprovalList
    }
// 	console.log(approvalVO);
    
    // 파일을 제외한 데이터 폼데이터에 추가
	formData.append("approvalVO", new Blob([JSON.stringify(approvalVO)], {type:"application/json;charset=utf-8"}));
	
    // 서버에 보내기
	fetch("/approval/submit",{
		method:"post",
		headers:{
			[header]: token
		},
		body:formData
	}).then((resp)=>{
		resp.text().then((data)=>{
// 			console.log(data);
			
			location.href="/approval/progress";
		})
	})
})

// 임시저장 버튼 클릭
$('#approveTempSave').on('click', function(){
	
	let content = jwEditor.getData();
	let title = $('#title').val() == null ? " " : $('#title').val();
	
	let formData = new FormData();
	
	let fileList = f_ckFileList();
	console.log("fileList", fileList);
	fileList.forEach(file => {
		formData.append("file", file);
	})
		
	let corbonCopyList = [];
    for (let i = 0; i < ccIdList.length; i++) {
    	corbonCopyList.push({accCc: ccIdList[i]});
    }
    
    let approvalLineList = [];
    approvalLineList.push({
		alAutzrNm: empId,
		alSeq: 1,
		alStts: "A01"    	
    })
    for(let i=0; i<alIdList.length; i++){
    	approvalLineList.push({
    		alAutzrNm: alIdList[i],
    		alSeq: i + 2,
    		alStts: i === 0 ? "A04" : "A05"
    	})
    }
    
    let aprvrEmgyn = document.querySelector('#aprvrEmgyn').checked;
    
    let checkRelList = document.querySelectorAll('.docNo');
    let relatedApprovalList = [];
    for(let i=0; i<checkRelList.length; i++){
    	relatedApprovalList.push({
    		raNo: checkRelList[i].innerText
    	})
    }
    
//     console.log(approvalLineList);
//     console.log(corbonCopyList);
//     console.log(aprvrEmgyn);
//     console.log(aprvrEmgyn === true ? "Y" : "N");
    
    let approvalVO = {
    	"aprvrDocTtl":title,
    	"empId": empId,
    	"aprvrDocCn":content,
    	"atCd":atCd,
    	"aprvrEmgyn": aprvrEmgyn === true ? "Y" : "N",
    	"approvalLineList":approvalLineList,
    	"corbonCopyList":corbonCopyList,
    	"aprvrSttsCd":"A00",
    	"relatedApprovalList":relatedApprovalList
    }
	
	formData.append("approvalVO", new Blob([JSON.stringify(approvalVO)], {type:"application/json;charset=utf-8"}));
	
	
	fetch("/approval/submit",{
		method:"post",
		headers:{
			[header]: token
		},
		body:formData
	}).then((resp)=>{
		resp.text().then((data)=>{
			console.log(data);
			location.href="/approval/tempsave";
		})
	})
})


// 파일 dropZone 바깥쪽 막기
window.addEventListener("dragover", function(){
    event.preventDefault();
});
window.addEventListener("drop", function(){
    event.preventDefault();
});

</script>
