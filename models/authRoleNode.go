package models

type AuthRoleNode struct {
	Id 		int
	NodeId  int
	RoleId	int64
}

func (m *AuthRoleNode) TableName() string {
	return TableName("auth_role_node")
}