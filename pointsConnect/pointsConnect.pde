/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/171057*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */

ArrayList<dot> points = new ArrayList<dot>();

void setup() {
	for (int i = 0; i < 1; ++i) {
		dot d = new dot();
		points.add(d);
	}
	size(960, 540);
}


void draw() {
	background(255);
	strokeWeight(5);
	for (int i = 0; i < points.size(); ++i) {
		points.get(i).draw();
		points.get(i).update();
	}
	for (int i = 0; i < points.size(); ++i) {
		int firJ = 0, secJ = 0;
		float distI = 500;
		for (int j = 0; j < points.size(); ++j) {
			if (dist(points.get(i).getX(), points.get(i).getY(), points.get(j).getX(), points.get(j).getY())<distI && j!=i) {
				distI = dist(points.get(i).getX(), points.get(i).getY(), points.get(j).getX(), points.get(j).getY());
				secJ = firJ;
				firJ = j;
			}
		}
		strokeWeight(1);
		line(points.get(i).getX(), points.get(i).getY(), points.get(firJ).getX(), points.get(firJ).getY());
		line(points.get(i).getX(), points.get(i).getY(), points.get(secJ).getX(), points.get(secJ).getY());
	}
	if (mousePressed) {
		dot d = new dot();
		d.setXY();
		points.add(d);
	}
	if (keyPressed) {
		if (key == 'k') {
			points.clear();
		}

	}

}

class dot {
	float pointX, pointY, speedX, speedY;
	dot() {
		pointX = random(0, 500);
		pointY = random(0, 500);
		speedX = random(-1, 1);
		speedY = random(-1, 1);
	}
	void draw(){
		point(pointX, pointY);
	}
	float getX(){
		return pointX;
	}
	float getY(){
		return pointY;
	}
	void setXY(){
		pointX = mouseX;
		pointY = mouseY;
	}
	void update(){
		if (pointX+speedX>width || pointX+speedX<0) {
			speedX *= -1;
		} else {
			pointX += speedX;
		}
		if (pointY+speedY>height || pointY+speedY<0) {
			speedY *= -1;
		} else {
			pointY += speedY;
		}
	}
}