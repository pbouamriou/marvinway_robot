#include <GL/gl.h>
#include <GL/glut.h>

GLfloat gAngle = 0.0;
GLUquadric *quad,*quad1; 

void timer(int value)
{
	const int desiredFPS=60;
	glutTimerFunc(1000/desiredFPS, timer, ++value);
	GLfloat dt = 1./desiredFPS;

	gAngle += dt*360./8.; //rotate 360 degrees every 8 seconds

	glutPostRedisplay(); // initiate display() call at desiredFPS rate
}

void init(void) {
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();
  gluPerspective(70,(double)640/480,0.01,1000);

  glEnable(GL_DEPTH_TEST);
  //glEnable(GL_CULL_FACE);
  glEnable(GL_COLOR_MATERIAL);    	
  // glEnable(GL_CULL_FACE);
  GLfloat lightpos[] = { 0.0, 5,5 };
  GLfloat lightcolor[] = { 0.5, 0.5, 0.5 };
  GLfloat diffusecolor[] = { 0.7, 0.7, 0.7 };
  GLfloat ambcolor[] = { 0.4, 0.4, 0.4 };
  GLfloat specular[] = {0.9, 0.9, 0.9};

  glEnable(GL_LIGHTING);                               // enable lighting
  glLightModelfv(GL_LIGHT_MODEL_AMBIENT,ambcolor);     // ambient light

  glEnable(GL_LIGHT0);                                 // enable light source
  glLightfv(GL_LIGHT0,GL_POSITION,lightpos);           // config light source
  glLightfv(GL_LIGHT0,GL_AMBIENT,lightcolor);
  glLightfv(GL_LIGHT0,GL_DIFFUSE,diffusecolor);
  glLightfv(GL_LIGHT0,GL_SPECULAR,specular);

  glEnable(GL_NORMALIZE);

}

void displayMe(void) {
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

  glMatrixMode(GL_MODELVIEW);
  //glEnable(GL_DEPTH_TEST);
  glLoadIdentity();
  
  gluLookAt(0.6,1,0.6, //eye
    0.0,0.0,0.0, //
    0.0,1.0,0.0); //up vector
  glTranslated(0,0,0);
  //glCullFace(GL_FRONT);
   glBegin(GL_LINES);
    glColor3f(1.0,0.0,0.0); 
    glVertex2i(0,0);glVertex2f(0.5f,0.0f); //x
    glColor3f(0.0,1.0,0.0);
    glVertex2i(0,0);glVertex2f(0.0f,0.5f); //y
    glColor3f(0.0,0.0,1.0);
    glVertex2i(0,0);glVertex3f(0.0f,0.0f,0.5f); //z
  glEnd();
  

  glColorMaterial(GL_FRONT,GL_AMBIENT_AND_DIFFUSE);
  glPushMatrix();
    glRotatef(gAngle,0.,0,1);
    glRotatef(90,0,1,0);
    glTranslatef(0,0,0.01);
    glColor4f(0.6,0.0,0.6,0.8);
    quad=gluNewQuadric();
    gluQuadricNormals(quad, GLU_SMOOTH);  // Create Smooth Normals ( NEW )
    gluQuadricDrawStyle(quad, GLU_FILL);  
    //glCullFace(GL_BACK);
    //gluQuadricTexture(quad, GL_TRUE);    // Create Texture Coords ( NEW )
    gluCylinder(quad, 0.10,0, 0.25,24, 1);
    
    //glColor3f(0.0,0.8,0.0);
    //glCullFace(GL_FRONT);
    gluDisk(quad,0,0.10,24,2);
    gluDeleteQuadric(quad);

  glPopMatrix();
  
  glutSwapBuffers();  
  glFlush();
}

int main(int argc, char** argv)
{
  glutInit(&argc, argv);
  glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
  glutInitWindowSize(640, 480);
  glutInitWindowPosition(100, 100);
  glutTimerFunc(0,timer,0);
  glutCreateWindow("Hello world :D");
  init();
  glutDisplayFunc(displayMe);
  glutMainLoop();
  return 0;
}
