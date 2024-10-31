import request from '@/utils/request'

// 查询项目分页列表
export function listPageProject(query) {
  return request({
    url: '/work/project/page',
    method: 'get',
    params: query
  })
}

// 查询项目列表
export function listProject(query) {
  return request({
    url: '/work/project/list',
    method: 'get',
    params: query
  })
}

// 查询员工项目列表
export function listStaffProject(query) {
  return request({
    url: '/work/project/listByStaff',
    method: 'get',
    params: query
  })
}

// 查询项目详细
export function getProject(id) {
  return request({
    url: '/work/project/' + id,
    method: 'get'
  })
}

// 新增项目
export function addProject(data) {
  return request({
    url: '/work/project',
    method: 'post',
    data: data
  })
}

// 修改项目
export function updateProject(data) {
  return request({
    url: '/work/project',
    method: 'put',
    data: data
  })
}

// 删除项目
export function delProject(id) {
  return request({
    url: '/work/project/' + id,
    method: 'delete'
  })
}
