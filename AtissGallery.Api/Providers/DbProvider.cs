using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace AtissGallery.Api.Providers
{
    public class DbProvider
    {
        private SqlConnection _connection;
        private SqlTransaction _transaction;

        public DbProvider()
        {
            _connection = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
        }

        public int ExecuteNonQuery(string commandText, CommandType commandType, SqlParameter[] parameters)
        {
            var result = -1;

            SqlCommand _command = _connection.CreateCommand();
            _command.CommandType = commandType;
            _command.CommandText = commandText;
            if (parameters != null)
            {
                _command.Parameters.AddRange(parameters);
            }

            try
            {
                if (_transaction == null)
                {
                    _connection.Open();
                }
                else
                {
                    _command.Transaction = _transaction;
                }

                result = _command.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (_transaction == null)
                {
                    _connection.Close();
                }
                _command.Dispose();
            }

            return result;
        }

        public DataTable ExecuteDataTable(string commandText, CommandType commandType, params SqlParameter[] parameters)
        {
            var result = new DataTable();

            SqlCommand _command = _connection.CreateCommand();
            _command.CommandType = commandType;
            _command.CommandText = commandText;
            _command.Parameters.Clear();
            if (parameters != null)
            {
                _command.Parameters.AddRange(parameters);
            }

            try
            {
                if (_transaction == null)
                {
                    _connection.Open();
                }
                else
                {
                    _command.Transaction = _transaction;
                }

                SqlDataAdapter dataAdapter = null;
                using (dataAdapter = new SqlDataAdapter(_command))
                {
                    dataAdapter.Fill(result);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (_transaction == null)
                {
                    _connection.Close();
                }
                _command.Dispose();
            }

            return result;
        }

        public void BeginTransaction()
        {
            _connection.Open();
            _transaction = _connection.BeginTransaction();
        }

        public void Commit()
        {
            if (_transaction != null)
            {
                _transaction.Commit();
                _connection.Close();
                _transaction.Dispose();
                _transaction = null;
            }
        }

        public void Rollback()
        {
            if (_transaction != null)
            {
                _transaction.Rollback();
                _connection.Close();
                _transaction.Dispose();
                _transaction = null;
            }
        }
    }
}