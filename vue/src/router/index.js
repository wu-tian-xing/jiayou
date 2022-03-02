import Vue from 'vue'
import Router from 'vue-router'
import Main from '../components/Main'
import Login from '../components/Login'

Vue.use(Router)
const originalPush = Router.prototype.push

Router.prototype.push = function push(location) {
    return originalPush.call(this, location).catch(err => err)
}

export default new Router({
    mode: 'history',
    routes: [{
        //    路由地址
        path: '/',
        //    跳转的组件
        component: Login,
        },
        {
            //    路由地址
            path: '/main',
            //    跳转的组件
            component: Main,
            // 重定向
            redirect: "/welcome",
            children: [
                {
                    path: "/welcome",
                    name: "Welcome",
                    component: () => import("../components/Welcome")
                },
                {
                    path: "/user",
                    name: "User",
                    component: () => import("../components/User")
                },
                {
                    path: "/note",
                    name: "Note",
                    component: () => import("../components/Note")
                },
                {
                    path: "/content",
                    name: "Content",
                    component: () => import("../components/Content")
                },
                {
                    path: "/text",
                    name: "Text",
                    component: () => import("../components/Text")
                },
                {
                  path: "/emotion",
                  name: "Emotion",
                    component: () => import("../components/Emotion")
                },
                {
                  path:"/euser",
                  name:"Euser",
                  component: () => import("../components/Euser")
                },
            ]
        }
    ]
})

