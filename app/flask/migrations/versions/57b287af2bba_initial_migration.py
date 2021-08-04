"""Initial migration.

Revision ID: 57b287af2bba
Revises: 
Create Date: 2021-08-04 12:33:02.346497

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '57b287af2bba'
down_revision = None
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('favorite_tech',
    sa.Column('id', sa.Integer(), autoincrement=True, nullable=False),
    sa.Column('name', sa.String(length=50), nullable=True),
    sa.Column('description', sa.String(length=400), nullable=True),
    sa.PrimaryKeyConstraint('id')
    )
    op.create_table('users',
    sa.Column('id', sa.Integer(), autoincrement=True, nullable=False),
    sa.Column('name', sa.String(length=50), nullable=True),
    sa.Column('username', sa.String(length=400), nullable=True),
    sa.Column('favorite_tech', sa.Integer(), nullable=True),
    sa.ForeignKeyConstraint(['favorite_tech'], ['favorite_tech.id'], ),
    sa.PrimaryKeyConstraint('id')
    )
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_table('users')
    op.drop_table('favorite_tech')
    # ### end Alembic commands ###
