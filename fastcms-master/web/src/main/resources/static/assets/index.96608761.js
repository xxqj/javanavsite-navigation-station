var x=Object.defineProperty;var y=Object.getOwnPropertySymbols;var A=Object.prototype.hasOwnProperty,B=Object.prototype.propertyIsEnumerable;var E=(l,n,t)=>n in l?x(l,n,{enumerable:!0,configurable:!0,writable:!0,value:t}):l[n]=t,M=(l,n)=>{for(var t in n||(n={}))A.call(n,t)&&E(l,t,n[t]);if(y)for(var t of y(n))B.call(n,t)&&E(l,t,n[t]);return l};import{_ as R,E as T,c as g,F as j}from"./index.b48d3751.js";import z from"./addMenu.4f943091.js";import L from"./editMenu.22bcadcf.js";import{r as k,j as O,J as N,o as V,t as I,l as _,m as u,z as o,A as s,E as q,b as D,D as i,p as f,q as H,y as C,x as p}from"./vendor.07d41a1e.js";import"./index.a6e3cd62.js";const J={name:"systemMenu",components:{AddMenu:z,EditMenu:L},setup(){const l=k(),n=k(),t=O({menuData:null}),r=N(()=>t.menuData),h=c=>{l.value.openDialog(c)},w=c=>{n.value.openDialog(c)},d=c=>{q.confirm("\u6B64\u64CD\u4F5C\u5C06\u6C38\u4E45\u5220\u9664\u8DEF\u7531, \u662F\u5426\u7EE7\u7EED?","\u63D0\u793A",{confirmButtonText:"\u5220\u9664",cancelButtonText:"\u53D6\u6D88",type:"warning"}).then(()=>{console.log(c),T(c.id).then(()=>{D.success("\u5220\u9664\u6210\u529F"),a(),g()}).catch(m=>{D.error(m.message)})}).catch(()=>{})},a=()=>{j().then(c=>{t.menuData=c.data}).catch(()=>{})};return V(()=>{a()}),M({addMenuRef:l,editMenuRef:n,onOpenAddMenu:h,onOpenEditMenu:w,menuTableData:r,onTabelRowDel:d,loadMenuList:a},I(t))}},K={class:"system-menu-container"},S=p("\u65B0\u5EFA\u8DEF\u7531"),$={class:"ml10"},G={key:0,class:"color-primary"},P={key:1,class:"color-info"},Q={key:0,class:"color-primary"},U={key:1,class:"color-info"},W={key:0,class:"color-primary"},X={key:1,class:"color-info"},Y={key:0,class:"color-primary"},Z={key:1,class:"color-info"},ee={key:0,class:"color-primary"},oe={key:1,class:"color-info"},te=p("\u65B0\u589E"),ne=p("\u4FEE\u6539"),ae=p("\u5220\u9664");function se(l,n,t,r,h,w){const d=_("el-button"),a=_("el-table-column"),c=_("el-table"),m=_("el-card"),F=_("AddMenu"),v=_("EditMenu");return i(),u("div",K,[o(m,{shadow:"hover"},{default:s(()=>[o(d,{onClick:r.onOpenAddMenu,class:"mt15",size:"small",type:"primary",icon:"iconfont icon-shuxingtu"},{default:s(()=>[S]),_:1},8,["onClick"]),o(c,{data:r.menuTableData,stripe:"",style:{width:"100%"},"row-key":"path","tree-props":{children:"children",hasChildren:"hasChildren"}},{default:s(()=>[o(a,{label:"\u83DC\u5355\u540D\u79F0","show-overflow-tooltip":""},{default:s(e=>[f("i",{class:H(e.row.meta.icon)},null,2),f("span",$,C(l.$t(e.row.meta.title)),1)]),_:1}),o(a,{prop:"name",label:"\u8DEF\u7531\u540D\u79F0","show-overflow-tooltip":""}),o(a,{prop:"path",label:"\u8DEF\u7531\u5730\u5740","show-overflow-tooltip":""}),o(a,{label:"\u7EC4\u4EF6\u5730\u5740","show-overflow-tooltip":""},{default:s(e=>[f("span",null,C(e.row.component),1)]),_:1}),o(a,{label:"\u9690\u85CF","show-overflow-tooltip":"",width:"70"},{default:s(e=>[e.row.meta.isHide?(i(),u("span",G,"\u662F")):(i(),u("span",P,"\u5426"))]),_:1}),o(a,{label:"\u7F13\u5B58","show-overflow-tooltip":"",width:"70"},{default:s(e=>[e.row.meta.isKeepAlive?(i(),u("span",Q,"\u662F")):(i(),u("span",U,"\u5426"))]),_:1}),o(a,{label:"\u56FA\u5B9A","show-overflow-tooltip":"",width:"70"},{default:s(e=>[e.row.meta.isAffix?(i(),u("span",W,"\u662F")):(i(),u("span",X,"\u5426"))]),_:1}),o(a,{label:"\u5916\u94FE","show-overflow-tooltip":"",width:"70"},{default:s(e=>[e.row.meta.isLink&&!e.row.meta.isIframe?(i(),u("span",Y,"\u662F")):(i(),u("span",Z,"\u5426"))]),_:1}),o(a,{label:"iframe","show-overflow-tooltip":"",width:"70"},{default:s(e=>[e.row.meta.isLink&&e.row.meta.isIframe?(i(),u("span",ee,"\u662F")):(i(),u("span",oe,"\u5426"))]),_:1}),o(a,{label:"\u64CD\u4F5C","show-overflow-tooltip":"",width:"125"},{default:s(e=>[o(d,{size:"mini",type:"text",onClick:b=>r.onOpenAddMenu(e.row)},{default:s(()=>[te]),_:2},1032,["onClick"]),o(d,{size:"mini",type:"text",onClick:b=>r.onOpenEditMenu(e.row)},{default:s(()=>[ne]),_:2},1032,["onClick"]),o(d,{size:"mini",type:"text",onClick:b=>r.onTabelRowDel(e.row)},{default:s(()=>[ae]),_:2},1032,["onClick"])]),_:1})]),_:1},8,["data"])]),_:1}),o(F,{ref:"addMenuRef",onReloadTable:r.loadMenuList},null,8,["onReloadTable"]),o(v,{ref:"editMenuRef",onReloadTable:r.loadMenuList},null,8,["onReloadTable"])])}var _e=R(J,[["render",se]]);export{_e as default};
