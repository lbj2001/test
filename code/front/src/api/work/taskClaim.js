import request from '@/utils/request'

// 查询任务认领列表
export function listTaskClaim(query) {
  return request({
    url: '/work/taskClaim/list',
    method: 'get',
    params: query
  })
}

// 查询任务认领详细
export function getTaskClaim(taskId) {
  return request({
    url: '/work/taskClaim/' + taskId,
    method: 'get'
  })
}

// 新增任务认领
export function addTaskClaim(data) {
  return request({
    url: '/work/taskClaim',
    method: 'post',
    data: data
  })
}

// 修改任务认领
export function updateTaskClaim(data) {
  return request({
    url: '/work/taskClaim',
    method: 'put',
    data: data
  })
}

// 删除任务认领
export function delTaskClaim(taskId) {
  return request({
    url: '/work/taskClaim/' + taskId,
    method: 'delete'
  })
}
