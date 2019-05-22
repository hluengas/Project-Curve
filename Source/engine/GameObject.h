#pragma once

#include <glm/glm.hpp>
#include <memory>
#include "../Program.h"
#include "../Shape.h"
#include "Collider.h"
#include "../MatrixStack.h"

class GameObject
{
public:
    GameObject(glm::vec3 position, glm::quat orientation, std::shared_ptr<Shape> model);
    GameObject();
    virtual void update(float dt) {};
    void draw(std::shared_ptr<Program> prog, std::shared_ptr<MatrixStack> M);

    glm::vec3 position;
    glm::quat orientation;
    int material;
    glm::vec3 scale;
    std::shared_ptr<Shape> model;
};