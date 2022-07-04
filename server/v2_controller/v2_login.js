const expressAsyncHandler = require("express-async-handler");
const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const V2Login = expressAsyncHandler(async (req, res) => {
  const { email, password } = req.body;
  const user = await prisma.users.findFirst({
    where: {
      email,
      password,
    },
    select: {
      Departement: {
        select: {
          id: true,
          name: true,
        },
      },
      id: true,
      email: true,
      name: true,
      Role: {
        select: {
          name: true,
          id: true,
        },
      },
      rolesId: true,
      departementsId: true
    },
  });

  if (!user) {
    throw new Error("tidak dapet usernya ");
  }
  res.json(user);
});

module.exports = V2Login;
