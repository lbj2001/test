import request from '@/utils/request'

// 查询工时分页统计列表
export function listPageTaskStatistics(query) {
  return request({
    url: '/work/taskStatistics/page',
    method: 'get',
    params: query
  })
}

// 查询工时统计列表
export function listTaskStatistics(query) {
  return request({
    url: '/work/taskStatistics/list',
    method: 'get',
    params: query
  })
}

// 查询工时统计详细
export function getTaskStatistics(id) {
  return request({
    url: '/work/taskStatistics/' + id,
    method: 'get'
  })
}

// 新增工时统计
export function addTaskStatistics(data) {
  return request({
    url: '/work/taskStatistics',
    method: 'post',
    data: data
  })
}

// 修改工时统计
export function updateTaskStatistics(data) {
  return request({
    url: '/work/taskStatistics',
    method: 'put',
    data: data
  })
}

// 删除工时统计
export function delTaskStatistics(id) {
  return request({
    url: '/work/taskStatistics/' + id,
    method: 'delete'
  })
}
