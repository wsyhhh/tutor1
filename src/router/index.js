import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'
import Topic1 from '../views/Topic1.vue'
import Topic2 from '../views/Topic2.vue'
import Topic3 from '../views/Topic3.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'home',
    component: Home
  },
  {
    path: '/topic1',
    name: 'topic1',
    component: Topic1
  },
  {
    path: '/topic2',
    name: 'topic2',
    component: Topic2
  },
  {
    path: '/topic3',
    name: '/topic3',
    component: Topic3
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
