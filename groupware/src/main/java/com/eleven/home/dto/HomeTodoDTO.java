package com.eleven.home.dto;

public class HomeTodoDTO {

	private String mem_id;
	private String content;
	private String done;
	private int todo_idx;
	
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getDone() {
		return done;
	}
	public void setDone(String done) {
		this.done = done;
	}
	public int getTodo_idx() {
		return todo_idx;
	}
	public void setTodo_idx(int todo_idx) {
		this.todo_idx = todo_idx;
	}
	
	
	
}
