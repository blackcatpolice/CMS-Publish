﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MailSend.aspx.cs" Inherits="ZoomLaCMS.Manage.User.Mail.MailSend" MasterPageFile="~/Manage/I/Default.Master" ValidateRequest="false"%>
<asp:Content runat="server" ContentPlaceHolderID="head">
<script type="text/javascript" src="/Plugins/Ueditor/ueditor.config.js"></script>
<script type="text/javascript" src="/Plugins/Ueditor/ueditor.all.min.js"></script>
<title>邮件发送</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<table class="table table-striped table-bordered table-hover">
  <tr>
    <td class="tdleft td_l"><strong>邮件模板：</strong></td>
      <td>
          <asp:DropDownList ID="MailTemp_DP" onchange="loadMailTlp(this.value);" class="form-control m715-50" runat="server">
          </asp:DropDownList></td>
  </tr>
  <tr>
    <td class="tdleft"><strong>收件人选择：</strong></td>
    <td>
        <div>
            <label><input type="radio" name="userRange_rad" value="email"/>Email</label>
            <label><input type="radio" name="userRange_rad" value="all" /> 所有会员</label>
            <label><input type="radio" name="userRange_rad" value="ulist" checked="checked"/>指定会员 <button type="button" class="btn btn-info btn-sm" onclick="user.sel('ulist', 'user', '');">选择用户</button></label>
        </div>
        <div class="userRange" id="ulist_wrap" style="max-height:200px;overflow-y:auto;"></div>
        <script>
            var ulist = new UserList({});
        </script>
        <div class="userRange" id="email_wrap" style="display:none;">
            <asp:TextBox runat="server" ID="Email_T" class="form-control m715-50" placeholder="请输入邮件地址"/>
        </div>
    </td>
  </tr>
  <tr>
        <td class="tdleft"><strong>发件人：</strong></td>
        <td>
            <asp:TextBox class="form-control m715-50" ID="TxtSenderName" runat="server" />
            <asp:RequiredFieldValidator ID="V1" runat="server" ControlToValidate="TxtSenderName" Display="None" ErrorMessage="发件人不能为空!" />
            <div class="rd_green">发件人姓名,该值不可为Email,否则可能会被目标邮箱过滤</div>
        </td>
    </tr> 
  <tr>
    <td class="tdleft"><strong>邮件主题：</strong></td>
    <td><asp:TextBox runat="server" ID="Subject_T"  class="form-control m715-50"/><span class="rd_red">*</span>
        <asp:RequiredFieldValidator ID="V2" runat="server" ControlToValidate="Subject_T" Display="None" ErrorMessage="邮件主题不能为空!" /></td>
  </tr>
  <tr>
    <td colspan="2"><asp:TextBox ID="TxtContent" runat="server" TextMode="MultiLine" style="height:400px;width:960px;"/></td>
  </tr>
    <tr>
        <td></td>
        <td>
            <asp:Button ID="BtnSend" runat="server" Text="发送邮件" OnClick="BtnSend_Click" class="btn btn-primary" />
            <a href="MailList.aspx" class="btn btn-info">返回列表</a>
        </td>
  </tr>
</table>
<asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True" ShowSummary="False" />
<div class="alert alert-info">
    <div>占位符支持标签,与用户数据</div>
    <div class="footbox">
        <span class="btn btn-default">账号: {UserName/}</span>
        <span class="btn btn-default">ID：{UserID/}</span>
        <span class="btn btn-default">公司名：{Company/}</span>
        <span class="btn btn-default">办公电话：{OfficePhone/}</span>
        <span class="btn btn-default">昵称: {HoneyName/}</span>
        <span class="btn btn-default">头像: {UserFace/}</span>
        <span class="btn btn-default">出生日期：{BirthDay/}</span>
        <span class="btn btn-default">E-mail地址：{Email/}</span>
    </div>
    </div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent"> 
<script src="/JS/Controls/ZL_Array.js"></script>
<script src="/JS/Controls/ZL_Dialog.js"></script>
<script src="/JS/jquery.validate.min.js"></script>
<script>
    $(function () {
        $("input[name='userRange_rad']").click(function () {
            $(".userRange").hide();
            $("#" + this.value + "_wrap").show();
        });
    })
    function SelectUser() {
        url = "/Office/Mail/SelGroup.aspx?Type=AllInfo";
        comdiag.maxbtn = false;
        ShowComDiag(url, "选择用户");
    }
    function UserFunc(json, select) {
        var uname = "";
        var uid = "";
        for (var i = 0; i < json.length; i++) {
            uname += json[i].UserName + ",";
            uid += json[i].UserID + ",";
        }
        if (uid) uid = uid.substring(0, uid.length - 1);
        $("#TxtUserName").val($("#TxtUserName").val()+uname);
        CloseComDiag();
    }
    function loadMailTlp(id) {
        $.post("", { tlpid: id }, function (data) {
            UE.getEditor("TxtContent").setContent(data);
        })
    }
</script> 
<%=Call.GetUEditor("TxtContent",2) %> 
</asp:Content>
