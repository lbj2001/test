import request from '@/utils/request'

// 查询项目来源列表
export function listProjectOrigin(query) {
  return request({
    url: '/work/projectOrigin/list',
    method: 'get',
    params: query
  })
}

// 查询项目来源详细
export function getProjectOrigin(id) {
  return request({
    url: '/work/projectOrigin/' + id,
    method: 'get'
  })
}

// 新增项目来源
export function addProjectOrigin(data) {
  return request({
    url: '/work/projectOrigin',
    method: 'post',
    data: data
  })
}

// 修改项目来源
export function updateProjectOrigin(data) {
  return request({
    url: '/work/projectOrigin',
    method: 'put',
    data: data
  })
}

// 删除项目来源
export function delProjectOrigin(id) {
  return request({
    url: '/work/projectOrigin/' + id,
    method: 'delete'
  })
}

// 查询项目来源列表
export function listSourceNos(projectNo, summaryNo) {
  return request({
    url: '/work/projectOrigin/listSourceNos?projectNo=' + projectNo + '&summaryNo=' + summaryNo,
    method: 'get'
  })
}
