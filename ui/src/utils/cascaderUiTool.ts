/**
 * 使用示例，后端接口返回只有最后一级id
 * 多选回显，多选是二维数组 [[1,2,3],[2,2,5]]后端只返回子节点id 3,5
 * let _list_check= data.list ? data.list.split(",").map(i => Number(i)):[];
 * let _arr = [];
 * _list_check && _list_check.map(i => _arr.push(this.getParentIdById(this.options,i)))
 * console.log("_arr:",_arr);
 * this._list_check =_arr;
 * 
 * 
 * 单值回显 [1,2,3]
 * let _list_check =data.list || "";
 * let _arr = [];
 * _arr = this.getParentIdById(this.options,_list_check)
 * this.list_check=_arr;
 */

export function getParentIdById(list:Array<string>,id:string):string{
	
	for (let i in list) {
		if(list[i].value == id){
			return [list[i].value];
		}
		if(list[i].children){
			let node = getParentIdById(list[i].children,id);
		    if(node !== undefined){
				//查询到把父节点加到数组前面
				node.unshift(list[i].value);
				return node;
			}
		}
	}
}


export function getLabelById(list:Array<string>,id:string):string{
	
	for (let i in list) {
		if(list[i].value == id){
			//console.log("label=",list[i].label);
			return list[i].label;
		}
		if(list[i].children){
			let node = getLabelById(list[i].children,id);
		    if(node !== undefined){
				//查询到把父节点加到数组前面
				//node.unshift(list[i].value);
				//console.log("node=",node);
				return node;
			}
		}
	}
}

export function getIdByLabel(list:Array<string>,label:string):string{
	
	for (let i in list) {
		if(list[i].label === label){
			return list[i].value;
		}
		if(list[i].children){
			let node = getIdByLabel(list[i].children,label);
		    if(node !== undefined){
				//查询到把父节点加到数组前面
				//node.unshift(list[i].value);
				return node;
			}
		}
	}
}