#include <iostream>
#include <GL/gl.h>
#include <GL/glut.h>
#include "KeyboardGyroStream.h"
#include "SerialGyroStream.h"

using namespace std;

void init(void) {
  //Set Projection witch a 70 degree field of view for a 640*480 aspect ration view
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();
  gluPerspective(70,(double)640/480,0.01,1000);
  
  // Enable depth test
  glEnable(GL_DEPTH_TEST);
  // Enable Material Color aspect to differentiate circle from a sphere
  glEnable(GL_COLOR_MATERIAL);    	

  // setting light source  position
  GLfloat lightpos[] = { 0.0, 5,5 };

  // setting light color 
  GLfloat lightcolor[] = { 0.5, 0.5, 0.5 };
  // setting light diffuse color
  GLfloat diffusecolor[] = { 0.7, 0.7, 0.7 };
  // setting light ambient color
  GLfloat ambcolor[] = { 0.4, 0.4, 0.4 };
  // setting light specular color
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

GLUquadric *quad;
IGyroStream *pGyroStream;

void drawLocator(void) {
  glBegin(GL_LINES);
    glColor3f(1.0,0.0,0.0); 
    glVertex2i(0,0);glVertex2f(0.5f,0.0f); //x
    glColor3f(0.0,1.0,0.0);
    glVertex2i(0,0);glVertex2f(0.0f,0.5f); //y
    glColor3f(0.0,0.0,1.0);
    glVertex2i(0,0);glVertex3f(0.0f,0.0f,0.5f); //z
  glEnd();
}

void draw(void) {
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
  //Draw scene
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();
   
  // setting camera position
  gluLookAt(0.6,1,0.6, // camera position
    0.0,0.0,0.0, // view location
    0.0,1.0,0.0); //up vector
  glTranslated(0,0,0);
  //Display locator 
  drawLocator(); 

  glColorMaterial(GL_FRONT,GL_AMBIENT_AND_DIFFUSE);
  // Display virtual gyroscope
  glPushMatrix();

    glRotatef(pGyroStream->yaw(),0,0,1);
    glRotatef(pGyroStream->roll(),1,0,0);
    glRotatef(pGyroStream->pitch(),0,1,0);
    glTranslatef(0,0,0.01);
    drawLocator();

    glColor4f(0.6,0.0,0.6,0.8);
    quad=gluNewQuadric();
    gluQuadricNormals(quad, GLU_SMOOTH);  // Create Smooth Normals ( NEW )
    gluQuadricDrawStyle(quad, GLU_FILL);  
    gluCylinder(quad, 0.10,0, 0.25,24, 1);
    
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
  glutCreateWindow("Locator");
  init(); 
//  pGyroStream=new KeyboardGyroStream();
  pGyroStream=new SerialGyroStream();
  glutDisplayFunc(draw);
  pGyroStream->init();
  glutMainLoop();
  pGyroStream->stop();
  delete[] pGyroStream;
  return 0;
}
