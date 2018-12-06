/** layuiAdmin.std-v1.1.0 LPPL License By http://www.layui.com/admin/ */
;layui.define(["table", "form"], function (e) {
    var $ = layui.$
        , table = layui.table;

    // 渲染 角色列表
    table.render({
        elem: "#LAY-user-back-role"
        , method: "POST"
        , url: "/auth/rolelist.html"
        , cols: [[{type: "checkbox", fixed: "left"}
            , {field: "Id", width: 80, title: "ID", sort: !0}
            , {field: "RoleName", title: "角色名"}
            , {field: "RoleAliasName", title: "角色名"}
            // , {field: "limits", title: "拥有权限"}
            , {field: "Descr", title: "具体描述"}
            , {
                title: "操作",
                width: 150,
                align: "center",
                fixed: "right",
                toolbar: "#table-useradmin-admin"
            }]]
        , limits: [5, 10, 20, 30, 40, 50, 60, 70, 80, 90]
        , page: !0
        , limit: 5
        , text: {
            none: '暂无相关数据！'//默认无数据
        }
    })
        // 删除角色
        , table.on("tool(LAY-user-back-role)", function (e) {
        // e.data;
        if ("del" === e.event) layer.confirm("确定删除此角色？", function (t) {

            console.log(e.data)
            // Ajax 请求后端删除
            $.ajax({
                url: '/auth/roledelete.html'
                , type: 'POST'
                , data: {id: e.data.Id}
                , async: false
                , dataType: 'json'
                , success: function (response) {

                    console.log(response)
                    if (response.code == 200) {
                        layer.alert(response.message);
                        e.del()
                    } else {
                        layer.alert(response.message);
                    }
                    layer.close(t)
                }
                , error: function (XMLHttpRequest, textStatus, errorThrown) {
                    console.log('XMLHttpRequest.status:' + XMLHttpRequest.status + ' XMLHttpRequest.readyState:' + XMLHttpRequest.readyState);
                    layer.alert(textStatus);
                }
            });

            // 编辑角色
        }); else if ("edit" === e.event) {
            // t(e.tr);
            layer.open({
                type: 2,
                title: "编辑角色",
                content: "role.html?id=" + e.data.Id,
                area: ["500px", "480px"],
                btn: ["确定", "取消"],
                yes: function (e, t) {
                    var l = window["layui-layer-iframe" + e],
                        r = t.find("iframe").contents().find("#LAY-user-role-submit");
                    l.layui.form.on("submit(LAY-user-role-submit)", function (t) {
                        var field = t.field; //获取提交的字段

                        console.log(t)
                        //提交 Ajax 成功后，静态更新表格中的数据
                        $.ajax({
                            url: '/auth/rolesave.html'
                            , type: 'POST'
                            , data: field
                            , async: false
                            , dataType: 'json'
                            , success: function (response) {

                                if (response.code == 200) {
                                    layer.alert(response.message);
                                    table.reload("LAY-user-back-role"), layer.close(e)
                                } else {
                                    layer.alert(response.message);
                                }
                            }
                            , error: function (XMLHttpRequest, textStatus, errorThrown) {
                                console.log('XMLHttpRequest.status:' + XMLHttpRequest.status + ' XMLHttpRequest.readyState:' + XMLHttpRequest.readyState);
                                layer.alert(textStatus);
                            }
                        });
                    }), r.trigger("click")
                },
                success: function (e, t) {
                }
            })
        }
    }), e("useradmin", {})
});