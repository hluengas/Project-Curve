#pragma once

#include "../engine/PhysicsObject.h"
#include <glm/glm.hpp>
#include <memory>
#include "../Shape.h"

class Box : public PhysicsObject
{
public:
    Box(glm::vec3 position);
    void init(std::shared_ptr<Shape> model);
};