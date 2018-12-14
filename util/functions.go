package util

import (
	"crypto/md5"
	"crypto/rand"
	"encoding/base64"
	"fmt"
	"go_demo/models"
	"io"
	"net/url"
	"strings"
)

func Md5(str string) string {
	hash := md5.New()
	hash.Write([]byte(str) )
	return fmt.Sprintf("%x", hash.Sum(nil))
}

func Rawurlencode(str string) string {
	return strings.Replace(url.QueryEscape(str), "+", "%20", -1)
}

//生成Guid字串
func UniqueId() string {
	b := make([]byte, 48)

	if _, err := io.ReadFull(rand.Reader, b); err != nil {
		return ""
	}
	return Md5(base64.URLEncoding.EncodeToString(b))
}

// 合并权限节点数据 递归返回树状结构  参考：https://blog.csdn.net/qq_15418761/article/details/81217146
func NodeDataMerge(nodeList [] *models.AuthPermission, pid int)  (dataList [] *models.AuthPermissionTree, err error) {


	// 遍历每一个节点
	for _, v := range nodeList {


		// 当前节点的Pid 如果 等于 pid 那么就说明他有子集
		if v.Pid == pid {

			// 通过递归查询子节点
			children, _ := NodeDataMerge(nodeList, v.Id)

			// 定义当前节点数据 并且 合并子节点
			parent := models.AuthPermissionTree{Id:v.Id, Title:v.Title, Pid:v.Pid, Level:v.Level, Status:v.Status, Route:v.Route, IsShow:v.IsShow, Child: children}

			// 将当前节点 合并 到结果集
			dataList = append(dataList, &parent)
		}
	}

	return dataList, nil

}
