color meshFillColor = color(0,0,255);

boolean meshStroke = true;
boolean meshFill = true;

void drawSpine() {
  noFill();
  stroke(255, 0, 0);
  beginShape();
  for (PVector v : spiral)
    curveVertex(v.x, v.y, v.z);
  endShape();
  
  stroke(0, 255, 0);
  for (PVector[] s : shell) {
    beginShape();
    for (PVector v : s)
      curveVertex(v.x, v.y, v.z);
    endShape(CLOSE);
  }
}

void drawMesh() {
  translate(0, 0, 100);
  lights();

  if (meshFill) {
    noStroke();
    fill(meshFillColor);
    render.drawFaces(mesh);
  }
  if (meshStroke) {
    if (meshFill) stroke(0);
    else stroke(255, alpha(meshFillColor));
    render.drawEdges(mesh);
  }
}
