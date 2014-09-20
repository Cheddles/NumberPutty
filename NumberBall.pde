//Adapted from

// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2010
// Box2DProcessing example

// A ball with a number in

class NumberBall {

  // We need to keep track of a Body and a width and height
  Body body;
  
  float posX;
  float posY;
  float diam;
  int value;
  color col;
  
  float angle;
  
  boolean dead;
  Vec2 pos;


  // Constructor
  Box(float x_, float y_, float diam_, int value_, color col_ ) {
    float posX = posX_;
    float posY = posY_;
    x = constrain(x, 20, width - 20);
    y = constrain(y, 20, height - 20);
    diam = diam_;
    value = value_;
    dead = false;
    // Add the box to the box2d world
    makeBody(new Vec2(posX, posY), diam);
  }

  // This function removes the particle from the box2d world
  void killBody() {
    box2d.destroyBody(body);
  }
  //this function is used to test if some coords are within the shape
  boolean contains(float x, float y) {
    Vec2 worldPoint = box2d.coordPixelsToWorld(x, y);
    Fixture f = body.getFixtureList();
    boolean inside = f.testPoint(worldPoint);
    return inside;
  }

  // Drawing the ball
  void display() {
    // We look at each body and get its screen position
    pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    angle = body.getAngle();

    ellipseMode(PConstants.CENTER);
    textAlign(PConstants.CENTER, PConstants.CENTER);
    textSize(20);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(angle);
    fill(col);
    noStroke();
    ellipse(0, 0, diam, diam);
    fill(255);
    text(value, 0, 0);

    popMatrix();
  }


  // This function adds the ball to the box2d world
  void makeBody(Vec2 center, float diam_) {
    // Define and create the body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));
    body = box2d.createBody(bd);

    // Make the body's shape a circle
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld((diam + 5)/2);


    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0.5;
    fd.restitution = 0.4;

    body.createFixture(fd);
    //body.setMassFromShapes();

    // Give it some initial random velocity
    body.setLinearVelocity(new Vec2(random(-5, 5), random(-5, 5)));
    body.setAngularVelocity(random(-5, 5));
  }
}

