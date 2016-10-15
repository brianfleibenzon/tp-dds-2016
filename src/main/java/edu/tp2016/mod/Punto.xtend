package edu.tp2016.mod

import javax.persistence.Entity
import javax.persistence.Column
import javax.persistence.GeneratedValue
import javax.persistence.Id

@Entity
class Punto {
	@Id
	@GeneratedValue
	private Long id
	
	@Column()
	public double x;
	
	@Column()
	public double y;
	
	new(double x, double y){
		this.x = x;
		this.y = y;
	}
	
	new(){}
}