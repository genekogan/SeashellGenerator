void generateShell(int n, int m)
{  
  // adjust resolution of mesh for number of shell turns
  n = (int) ( n * turns / 10.0);

  spiral = new PVector[n];
  shell = new PVector[n][m];

  // Get vertices for the shell
  for (int i = 0; i < n; i++) 
  {
    // Generate main spiral
    float theta = map(i, 0, n, 0, turns);
    float rad = exp( theta * cos(alpha) / sin(alpha) );

    float x =  A * rad * sin(beta) * cos(theta) * D;
    float y =  A * rad * sin(beta) * sin(theta);
    float z = -A * rad * cos(beta);
        
    spiral[i] = new PVector(x, y, z);
    
    // Generate ellipse around each point of spiral
    for (int j = 0; j < m; j++) 
    {
      float s = map(j, 0, m, 0, TWO_PI);  
      float r2 = pow( pow(cos(s)/a,2) + pow(sin(s)/b,2), -0.5 );
      
      // add surface manipulations
      float surfrad = 0;
      if (W1==0 || W2==0 || N==0) surfrad = 0;
      else {
        float lt = (TWO_PI / N) * ( N*theta / TWO_PI - int(N*theta / TWO_PI) );
        surfrad = L * exp( -( pow(2*(s-P)/W1, 2) + pow(2*lt/W2, 2) ) );          
      }
      r2 += surfrad;
      
      x = cos(s + phi) * cos(theta + omega) * r2 * rad * D;   // here  rad - 1 closes the opening of the curve at the origin
      y = cos(s + phi) * sin(theta + omega) * r2 * rad;
      z = sin(s + phi)                      * r2 * rad;
      
      // adjust orientation of the 
      x -= sin(mu) * sin(s + phi) * sin(theta + omega) * r2;
      y += sin(mu) * sin(s + phi) * cos(theta + omega) * r2;
      z *= cos(mu);
      
      shell[i][j] = PVector.add(spiral[i], new PVector(x, y, z));
    }
  }
}


// create mesh from above vertex data
void generateMesh(int n, int m)
{
  // adjust resolution of mesh for number of shell turns
  n = (int) (n * turns / 20.0);

  // vertices
  float[][] vertices = new float[ n * m ][3];
  int index = 0;
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < m; j++) {
      vertices[index][0] = shell[i][j].x;
      vertices[index][1] = shell[i][j].y;
      vertices[index][2] = shell[i][j].z;
      index++;
    }
  }
  
  // faces
  index = 0;
  int[][] faces = new int[ (n-1)*m ][4];
  for (int j = 0; j < n-1; j++) {
    for (int i = 0; i < m; i++) {
      faces[index][0] = i + m * j;
      faces[index][1] = (i + 1) % m + m * j;
      faces[index][2] = (i + 1) % m + m * (j + 1);
      faces[index][3] = i + m * (j + 1);
      index++;
    }
  }

  // HE_mesh creator
  HEC_FromFacelist creator=new HEC_FromFacelist();
  creator.setVertices(vertices);
  creator.setFaces(faces);
  creator.setDuplicate(false);
  mesh = new HE_Mesh(creator);
}
